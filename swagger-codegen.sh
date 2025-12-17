#!/bin/bash
# exit on error
set -e

# Generate Ruby clients from the checked-out SP-API models snapshot, driven by .codegen-plan.
#
#
# Plan line format:
#   <model>/<prefix>@<version>#<sha>[; flag,flag,...]
#     - <sha> may be a full 40-hex blob SHA or a short prefix (e.g. 7 chars)
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

# Inputs
PLAN_FILE="${PLAN_FILE:-.codegen-plan}"

# Prefer MODELS_DIR from .models/.env (produced by pull_models.sh). Fall back to MODELS_ROOT for older callers.
MODELS_DIR="${MODELS_DIR:-${MODELS_ROOT:-../selling-partner-api-models/models}}"
MODELS_ROOT="$MODELS_DIR"
CONFIG_TEMPLATE="${CONFIG_TEMPLATE:-config.json}"
FINAL_LIB_ROOT="${LIB_ROOT:-lib}"
STAGE_ROOT="${STAGE_ROOT:-.codegen-stage}"
ACTIVE_LIB_ROOT="$FINAL_LIB_ROOT"

if [[ "$STAGE" == "1" ]]; then
  ACTIVE_LIB_ROOT="$STAGE_ROOT/lib"
fi

LIB_ROOT="$ACTIVE_LIB_ROOT"

if [[ ! -f "$PLAN_FILE" ]]; then
  echo "Missing plan file: $PLAN_FILE" >&2
  echo "Hint: expected '$PLAN_FILE' in $ROOT_DIR (or set PLAN_FILE=...)" >&2
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

# Ensure final lib root exists or can be created
mkdir -p "$FINAL_LIB_ROOT"

# If staging and not dry-run, ensure the stage root is clean and created
if [[ "$DRY_RUN" != "1" && "$STAGE" == "1" ]]; then
  rm -rf "$STAGE_ROOT"
  mkdir -p "$STAGE_ROOT/lib"
fi

command -v swagger-codegen >/dev/null 2>&1 || {
  echo "Missing required command: swagger-codegen" >&2
  exit 1
}

# Only require rsync if --apply is set and not dry-run
if [[ "$APPLY" == "1" && "$DRY_RUN" != "1" ]]; then
  command -v rsync >/dev/null 2>&1 || {
    echo "Missing required command for --apply: rsync" >&2
    exit 1
  }
fi

DRY_RUN=0
STAGE=0
DIFF_ONLY=0
APPLY=0

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=1
      ;;
    --stage)
      STAGE=1
      ;;
    --diff-only)
      STAGE=1
      DIFF_ONLY=1
      ;;
    --apply)
      STAGE=1
      APPLY=1
      ;;
  esac
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

# Verify that the spec JSON we are about to feed into swagger-codegen matches the plan's blob SHA.
# This guards against path resolution mistakes.
verify_spec_sha() {
  local spec_json="$1"
  local expected_sha="$2"

  [[ -z "$expected_sha" ]] && return 0

  local repo_root rel actual_sha

  repo_root="$(cd "$MODELS_ROOT/.." && pwd -P)"

  # If spec_json is inside the models repo, prefer git hash-object on the repo-relative path.
  if [[ "$spec_json" == "$repo_root/"* ]]; then
    rel="${spec_json#"$repo_root/"}"
    actual_sha="$(cd "$repo_root" && git hash-object "$rel")"
  else
    # Fallback: hash the file contents directly.
    actual_sha="$(git hash-object "$spec_json")"
  fi

  # Accept either full 40-hex or short prefix SHAs from the plan.
  if [[ "$actual_sha" != "$expected_sha"* ]]; then
    echo "Spec SHA mismatch for $spec_json" >&2
    echo "  expected (prefix): $expected_sha" >&2
    echo "  actual:            $actual_sha" >&2
    return 1
  fi

  return 0
}

# Locate the JSON spec by blob SHA from the models git repo.
# The plan's `#<sha>` is the blob SHA of the spec file contents.
# We resolve it to a repo-relative path, and (when possible) constrain it to the expected model prefix.
resolve_spec_json_by_sha() {
  local model="$1"
  local sha="$2"

  local repo_root matches constrain

  # MODELS_ROOT points at: <models-repo>/models
  # so the git repo root is MODELS_ROOT/..
  repo_root="$(cd "$MODELS_ROOT/.." && pwd -P)"

  # Constrain to the model directory when possible.
  # e.g. models/finances-api-model/
  constrain="models/${model}/"

  # Find all paths at HEAD whose blob SHA matches.
  # Allow short SHAs: match any object whose full SHA starts with the provided prefix.
  # Output format: <mode> <type> <object>\t<path>
  matches="$(cd "$repo_root" && git ls-tree -r HEAD | awk -v s="$sha" 'index($3,s)==1 {print $NF}')"

  if [[ -z "$matches" ]]; then
    return 1
  fi

  # Prefer a match within the expected model dir.
  local in_model
  in_model="$(printf '%s\n' "$matches" | awk -v p="$constrain" 'index($0,p)==1 && $0 ~ /\.json$/ {print $0}' | head -n 1)"
  if [[ -n "$in_model" ]]; then
    echo "$repo_root/$in_model"
    return 0
  fi

  # Otherwise, take the first json match anywhere (should be rare; indicates the sha wasn't model-specific).
  local any_spec
  # Prefer JSON first, but allow MD to be located so we can emit a clear error upstream.
  any_spec="$(printf '%s\n' "$matches" | awk '$0 ~ /\.(json|md)$/ {print $0}' | head -n 1)"
  if [[ -n "$any_spec" ]]; then
    echo "$repo_root/$any_spec"
    return 0
  fi

  return 2
}

# Find the spec JSON for a plan entry.
# The SP-API models snapshot uses a *flat* layout inside each API folder:
#   <MODELS_ROOT>/<model>/<prefix>_<version>.json
# (Some APIs may also include .md files, but swagger-codegen needs the JSON spec.)
#
# Resolution order:
#   1) Exact flat filename match
#   2) Resolve by blob SHA (robust against renames) within the model dir
find_spec_json() {
  local model="$1"
  local prefix="$2"
  local version="$3"
  local sha="$4"

  local model_dir

  model_dir="$MODELS_ROOT/$model"

  # 1) Preferred flat-file naming, allowing joiners: <prefix><sep><version>.json where sep ∈ {"", "-", "_"}
  local sep
  for sep in "" "-" "_"; do
    flat_json="$model_dir/${prefix}${sep}${version}.json"
    if [[ -f "$flat_json" ]]; then
      echo "$flat_json"
      return 0
    fi
  done

  # 2) Resolve by blob SHA (most robust, ignores naming/layout).
  if [[ -n "$sha" ]]; then
    local resolved
    resolved="$(resolve_spec_json_by_sha "$model" "$sha" || true)"
    if [[ -n "$resolved" ]]; then
      # We only accept JSON specs for codegen.
      if [[ "$resolved" != *.json ]]; then
        echo "Resolved blob SHA to a non-JSON file (cannot codegen): $resolved" >&2
        return 2
      fi
      echo "$resolved"
      return 0
    fi
  fi

  return 1
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

  spec_json="$(find_spec_json "$model" "$prefix" "$version" "$sha")" || {
    echo "No spec JSON found for: $model/$prefix@$version#$sha (from: $raw_line)" >&2
    echo "Tried:" >&2
    echo "  $MODELS_ROOT/$model/${prefix}${version}.json" >&2
    echo "  $MODELS_ROOT/$model/${prefix}-${version}.json" >&2
    echo "  $MODELS_ROOT/$model/${prefix}_${version}.json" >&2
    exit 1
  }

  verify_spec_sha "$spec_json" "$sha" || {
    echo "Refusing to run codegen due to SHA mismatch (from: $raw_line)" >&2
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

if [[ "$DRY_RUN" != "1" && "$STAGE" == "1" ]]; then
  echo "[diff] $FINAL_LIB_ROOT <-> $ACTIVE_LIB_ROOT"
  git diff --no-index -- "$FINAL_LIB_ROOT" "$ACTIVE_LIB_ROOT" || true

  if [[ "$DIFF_ONLY" == "1" ]]; then
    echo "[diff-only] not applying staged output"
    exit 0
  fi

  if [[ "$APPLY" == "1" ]]; then
    echo "[apply] promoting staged output into $FINAL_LIB_ROOT"
    rsync -a --delete "$ACTIVE_LIB_ROOT/" "$FINAL_LIB_ROOT/"
    echo "[apply] done"
  else
    echo "[stage] staged output is in $ACTIVE_LIB_ROOT (run with --apply to promote)"
  fi
fi
