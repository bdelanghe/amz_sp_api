#!/bin/bash
# exit on error
set -e

# Generate Ruby clients from the checked-out SP-API models snapshot, driven by .codegen-plan.
#
# Plan line format:
#   <model>/<prefix>@<version>#<sha>[; flag,flag,...]
#
# Flags we currently honor here:
#   - skip_deprecated   => do not generate
#   - skip_legacy       => do not generate (unless supported_legacy is also present)
#   - supported_legacy  => generate even if legacy
#   - use_prefix_namespace  => gem/module/output are namespaced by prefix (always true in this generator)
#   - use_version_namespace => gem/module/output are additionally namespaced by version

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

# Optional environment overrides (kept simple / local to the repo).
# This can set PLAN_FILE, MODELS_ROOT, LIB_ROOT, etc.
if [[ -f "$ROOT_DIR/env.sh" ]]; then
  # shellcheck disable=SC1091
  source "$ROOT_DIR/env.sh"
fi

PLAN_FILE="${PLAN_FILE:-.codegen-plan}"
# Prefer MODELS_ROOT if explicitly set; otherwise use MODELS_DIR from .models/.env when available.
# MODELS_DIR is expected to point at the snapshot's `models/` directory.
MODELS_ROOT="${MODELS_ROOT:-${MODELS_DIR:-../selling-partner-api-models/models}}"
CONFIG_TEMPLATE="${CONFIG_TEMPLATE:-config.json}"
LIB_ROOT="${LIB_ROOT:-lib}"

if [[ ! -f "$PLAN_FILE" ]]; then
  echo "Missing plan file: $PLAN_FILE" >&2
  exit 1
fi
if [[ ! -d "$MODELS_ROOT" ]]; then
  echo "Missing models root dir: $MODELS_ROOT" >&2
  echo "Hint: set MODELS_ROOT or MODELS_DIR (e.g., via .models/.env produced by ./pull_models.sh)" >&2
  exit 1
fi
if [[ ! -f "$CONFIG_TEMPLATE" ]]; then
  echo "Missing config template: $CONFIG_TEMPLATE" >&2
  exit 1
fi
command -v swagger-codegen >/dev/null 2>&1 || {
  echo "Missing required command: swagger-codegen" >&2
  exit 1
}

DRY_RUN=0
for arg in "$@"; do
  if [[ "$arg" == "--dry-run" ]]; then
    DRY_RUN=1
    break
  fi
done

# Convert things like:
#   fulfillmentInbound   -> FulfillmentInbound
#   vendorDirect...      -> VendorDirect...
#   shipping             -> Shipping
#   V0                   -> V0
#   2024-03-20           -> 20240320
camelize() {
  local s="$1"
  # Preserve already-CamelCase strings; just strip separators and capitalize boundaries.
  printf '%s' "$s" | perl -pe 's/[^A-Za-z0-9]+/-/g; s/(^|-)./uc($&)/ge; s/-//g'
}

sanitize_version_token() {
  local v="$1"
  # Remove dashes (dates) so it becomes a legal Ruby constant fragment.
  # e.g. 2024-03-20 -> 20240320
  printf '%s' "$v" | tr -cd 'A-Za-z0-9'
}

has_flag() {
  local flags_csv="$1"
  local needle="$2"
  [[ ",${flags_csv}," == *",${needle},"* ]]
}

# Locate the JSON spec by blob SHA from the models git repo.
# The plan's `#<sha>` is the blob SHA of the spec file contents.
# We resolve it to a repo-relative path, and (when possible) constrain it to the expected leaf dir.
resolve_spec_json_by_sha() {
  local leaf_dir="$1"
  local sha="$2"

  local repo_root leaf_rel matches

  # MODELS_ROOT points at: <models-repo>/models
  # so the git repo root is MODELS_ROOT/..
  repo_root="$(cd "$MODELS_ROOT/.." && pwd -P)"

  # leaf_dir is an absolute or relative path; normalize to absolute so we can derive a repo-relative prefix.
  leaf_dir="$(cd "$leaf_dir" && pwd -P)"

  # Derive repo-relative leaf prefix (e.g. models/finances-api-model/finances/V0)
  leaf_rel="${leaf_dir#"$repo_root"/}"

  # Find all paths at HEAD whose blob SHA matches.
  # Output format: <mode> <type> <object>\t<path>
  matches="$(cd "$repo_root" && git ls-tree -r HEAD | awk -v s="$sha" '$3==s {sub(/^\t/,"",$4); print $4}')"

  if [[ -z "$matches" ]]; then
    return 1
  fi

  # Prefer a match within the expected leaf dir.
  local in_leaf
  in_leaf="$(printf '%s\n' "$matches" | awk -v p="$leaf_rel/" 'index($0,p)==1 && $0 ~ /\.json$/ {print $0}' | head -n 1)"
  if [[ -n "$in_leaf" ]]; then
    echo "$repo_root/$in_leaf"
    return 0
  fi

  # Otherwise, take the first json match anywhere (should be rare; indicates the sha wasn't leaf-specific).
  local any_json
  any_json="$(printf '%s\n' "$matches" | awk '$0 ~ /\.json$/ {print $0}' | head -n 1)"
  if [[ -n "$any_json" ]]; then
    echo "$repo_root/$any_json"
    return 0
  fi

  return 2
}

# Find exactly one JSON spec inside a leaf directory, but prefer resolving by blob SHA first.
find_spec_json() {
  local leaf_dir="$1"
  local sha="$2"

  # First choice: resolve by blob SHA so we don't depend on directory heuristics.
  if [[ -n "$sha" ]]; then
    if resolve_spec_json_by_sha "$leaf_dir" "$sha"; then
      return 0
    fi
  fi

  # Fallback: Prefer openapi.json if it exists (common convention), otherwise any *.json.
  if [[ -f "$leaf_dir/openapi.json" ]]; then
    echo "$leaf_dir/openapi.json"
    return 0
  fi

  local found
  found="$(find "$leaf_dir" -maxdepth 1 -type f -name "*.json" | head -n 1 || true)"
  if [[ -z "$found" ]]; then
    return 1
  fi
  echo "$found"
}

# Drive generation from the plan.
while IFS= read -r raw_line; do
  # Skip blanks / comments
  [[ -z "${raw_line// }" ]] && continue
  [[ "$raw_line" == \#* ]] && continue

  # Split "left; flags".
  left="${raw_line%%;*}"
  flags_part=""
  if [[ "$raw_line" == *";"* ]]; then
    flags_part="${raw_line#*; }"
    flags_part="${flags_part// /}"
  fi

  model="${left%%/*}"
  rest="${left#*/}"            # prefix@version#sha
  prefix="${rest%%@*}"
  rest2="${rest#*@}"          # version#sha
  version="${rest2%%#*}"
  sha="${rest2#*#}"

  # Honor skip flags.
  if has_flag "$flags_part" "skip_deprecated"; then
    echo "[skip_deprecated] $model/$prefix@$version#$sha"
    continue
  fi
  if has_flag "$flags_part" "skip_legacy" && ! has_flag "$flags_part" "supported_legacy"; then
    echo "[skip_legacy] $model/$prefix@$version#$sha"
    continue
  fi

  leaf_dir="$MODELS_ROOT/$model/$prefix/$version"
  if [[ ! -d "$leaf_dir" ]]; then
    echo "Missing leaf dir: $leaf_dir (from: $raw_line)" >&2
    exit 1
  fi

  spec_json="$(find_spec_json "$leaf_dir" "$sha")" || {
    echo "No *.json found in leaf dir: $leaf_dir (from: $raw_line)" >&2
    exit 1
  }

  # Output naming:
  # - By default, namespace only by model (ignore prefix) to match swagger-codegen's typical behavior.
  # - If use_prefix_namespace is present, include the prefix to avoid collisions in shared model dirs.
  # - If use_version_namespace is present, additionally include version to avoid collisions across versions.
  # Base naming:
  #   default:  <model>
  #   +prefix:  <model>-<prefix>
  #   +version: append `-<versionToken>` and add to module constant
  out_name_base="$model"
  module_base="$(camelize "$model")"

  if has_flag "$flags_part" "use_prefix_namespace"; then
    out_name_base="${model}-${prefix}"
    module_base="$(camelize "$prefix")"
  fi

  out_name="$out_name_base"
  module_name="$module_base"

  if has_flag "$flags_part" "use_version_namespace"; then
    ver_tok="$(sanitize_version_token "$version")"
    out_name="${out_name_base}-${ver_tok}"
    module_name="${module_base}$(camelize "$ver_tok")"
  fi

  out_dir="$LIB_ROOT/$out_name"

  if [[ "$DRY_RUN" == "1" ]]; then
    echo "[dry-run] would generate $spec_json -> $out_dir (module=$module_name sha=$sha)"
  else
    echo "[generate] $spec_json -> $out_dir (module=$module_name sha=$sha)"
  fi

  if [[ "$DRY_RUN" != "1" ]]; then
    rm -rf "$out_dir"
    mkdir -p "$out_dir"
  fi

  if [[ "$DRY_RUN" != "1" ]]; then
    # Prepare per-gem config.json
    cp "$CONFIG_TEMPLATE" "$out_dir/config.json"
    sed -i '' "s/GEMNAME/${out_name}/g" "$out_dir/config.json"
    sed -i '' "s/MODULENAME/${module_name}/g" "$out_dir/config.json"

    swagger-codegen generate \
      -i "$spec_json" \
      -l ruby \
      -c "$out_dir/config.json" \
      -o "$out_dir"

    # Normalize output layout to match repo conventions:
    # - Hoist lib/<gem>.rb to lib/
    # - Hoist lib/<gem>/* into lib/<gem>/
    #
    # swagger-codegen ruby output tends to create:
    #   <out_dir>/lib/<gem>.rb
    #   <out_dir>/lib/<gem>/*
    # We want:
    #   lib/<out_name>.rb
    #   lib/<out_name>/*

    if [[ -f "$out_dir/lib/${out_name}.rb" ]]; then
      mv "$out_dir/lib/${out_name}.rb" "$LIB_ROOT/"
    fi

    if [[ -d "$out_dir/lib/${out_name}" ]]; then
      mkdir -p "$LIB_ROOT/${out_name}"
      mv "$out_dir/lib/${out_name}"/* "$LIB_ROOT/${out_name}/"
    fi

    rm -rf "$out_dir/lib" || true
    rm -f "$out_dir"/*.gemspec || true
  fi

done < "$PLAN_FILE"
