#!/bin/bash
# exit on error
set -euo pipefail

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
#   - use_prefix_namespace  => gem/module/output are namespaced by prefix
#   - use_version_namespace => gem/module/output are additionally namespaced by version

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

# Optional environment overrides (kept simple / local to the repo).
# This can set PLAN_FILE, MODELS_ROOT, LIB_ROOT, etc.
if [[ -f "$ROOT_DIR/env.sh" ]]; then
  # shellcheck disable=SC1091
  source "$ROOT_DIR/env.sh"
fi

# Logs for swagger-codegen output (kept out of stdout unless explicitly viewed)
CODEGEN_LOG_DIR="${CODEGEN_LOG_DIR:-.codegen-logs}"

DRY_RUN=0
STAGE=0
DIFF_ONLY=0
APPLY=0
NAME_ONLY=0
LIST_API_CHANGES=0
FORCE="${FORCE:-0}"
[[ "$FORCE" == "1" ]] || FORCE="0"


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
    --name-only)
      NAME_ONLY=1
      ;;
    --list-api-changes)
      LIST_API_CHANGES=1
      ;;
    --force)
      FORCE=1
      ;;
  esac
done

# --list-api-changes is an inspection mode: only parse the plan and report statuses.
# It should NOT stage/diff/generate.
if [[ "$LIST_API_CHANGES" == "1" ]]; then
  STAGE=0
  DIFF_ONLY=0
  APPLY=0
fi

# Final destination for generated code. Keep this distinct from LIB_ROOT so
# staging/diffing can't accidentally point both sides at the same directory.
FINAL_LIB_ROOT="${FINAL_LIB_ROOT:-lib}"

# Where staged output is written when --stage/--diff-only/--apply are used.
STAGE_ROOT="${STAGE_ROOT:-.codegen-stage}"

# ACTIVE_LIB_ROOT is where this run will write its output.
ACTIVE_LIB_ROOT="$FINAL_LIB_ROOT"
if [[ "$STAGE" == "1" ]]; then
  ACTIVE_LIB_ROOT="$STAGE_ROOT/lib"
fi

# LIB_ROOT is used by the generator as the output root for this run.
LIB_ROOT="$ACTIVE_LIB_ROOT"

# Inputs
PLAN_FILE="${PLAN_FILE:-.codegen-plan}"

# Prefer MODELS_DIR from .models/.env (produced by pull_models.sh). Fall back to MODELS_ROOT for older callers.
MODELS_DIR="${MODELS_DIR:-${MODELS_ROOT:-../selling-partner-api-models/models}}"
MODELS_ROOT="$MODELS_DIR"
CONFIG_TEMPLATE="${CONFIG_TEMPLATE:-config.json}"

# Ensure log dir exists early (even for dry-runs we may want to reference it)
mkdir -p "$CODEGEN_LOG_DIR"

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

# If staging and not dry-run, ensure the stage root is clean and created.
# Seed the stage lib from the current lib so the diff only reflects what
# codegen would *change*, not every file that isn't regenerated this run.
if [[ "$DRY_RUN" != "1" && "$STAGE" == "1" ]]; then
  rm -rf "$STAGE_ROOT"
  mkdir -p "$STAGE_ROOT/lib"

  # If lib already exists, copy it into the stage area first.
  # This avoids misleading diffs where non-generated files appear "deleted".
  if [[ -d "$FINAL_LIB_ROOT" ]]; then
    if command -v rsync >/dev/null 2>&1; then
      rsync -a "$FINAL_LIB_ROOT/" "$ACTIVE_LIB_ROOT/"
    else
      # Fallback: best-effort copy without rsync.
      cp -a "$FINAL_LIB_ROOT/." "$ACTIVE_LIB_ROOT/"
    fi
  fi
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

sed_inplace() {
  local expr="$1"
  local file="$2"

  # GNU sed supports: sed -i -e 's/a/b/' file
  # BSD/macOS sed supports: sed -i '' -e 's/a/b/' file
  if sed --version >/dev/null 2>&1; then
    sed -i -e "$expr" "$file"
  else
    sed -i '' -e "$expr" "$file"
  fi
}

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

is_tty() {
  [[ -t 1 ]]
}

# Respect NO_COLOR and disable colors when stdout isn't a TTY.
USE_COLOR=0
if is_tty && [[ -z "${NO_COLOR:-}" ]]; then
  USE_COLOR=1
fi

c_reset() { [[ "$USE_COLOR" == "1" ]] && printf '\033[0m' || true; }
# Basic palette
c_dim()   { [[ "$USE_COLOR" == "1" ]] && printf '\033[2m' || true; }
c_red()   { [[ "$USE_COLOR" == "1" ]] && printf '\033[31m' || true; }
c_green() { [[ "$USE_COLOR" == "1" ]] && printf '\033[32m' || true; }
c_yellow(){ [[ "$USE_COLOR" == "1" ]] && printf '\033[33m' || true; }
c_cyan()  { [[ "$USE_COLOR" == "1" ]] && printf '\033[36m' || true; }

emit_api_status() {
  local api="$1"          # canonical API id: <model>/<prefix>@<version>
  local status="$2"       # cached | generate | skip_deprecated | skip_legacy | dry_run | supported
  local sha="$3"          # short or full

  # Human-friendly labels
  local label="$status"
  case "$status" in
    cached)          label="cached" ;;
    generate)        label="generate" ;;
    dry_run)         label="dry_run" ;;
    skip_legacy)     label="legacy" ;;
    skip_deprecated) label="deprecated" ;;
    supported)       label="supported" ;;
  esac

  # Color only the bracketed status token.
  local color_fn=""
  case "$status" in
    cached)           color_fn="c_green" ;;
    generate)         color_fn="c_yellow" ;;
    dry_run)          color_fn="c_cyan" ;;
    skip_legacy)      color_fn="c_dim" ;;
    skip_deprecated)  color_fn="c_red" ;;
    supported)        color_fn="c_yellow" ;;
    *)                color_fn="" ;;
  esac

  # Display SHA like git (short, no `sha=` prefix)
  local sha_tok="$sha"
  if [[ "${#sha_tok}" -gt 12 ]]; then
    sha_tok="${sha_tok:0:12}"
  fi

  # Tab-separated output keeps columns aligned without padding inside brackets.
  # Format:
  #   [status]\t<sha>\t<api>
  if [[ -n "$color_fn" ]]; then
    local open close
    open="$($color_fn 2>/dev/null || true)"
    close="$(c_reset 2>/dev/null || true)"
    printf '%s[%s]%s\t%s\t%s\n' "$open" "$label" "$close" "$sha_tok" "$api"
  else
    printf '[%s]\t%s\t%s\n' "$label" "$sha_tok" "$api"
  fi
}

breadcrumb_path_for() {
  local out_name="$1"
  # Store breadcrumb alongside the generated Ruby module tree.
  echo "$LIB_ROOT/$out_name/.codegen-source"
}

breadcrumb_matches() {
  local out_name="$1"
  local expected_sha="$2"

  # If no expected sha is provided, we can't safely cache-skip.
  [[ -z "$expected_sha" ]] && return 1

  local crumb
  crumb="$(breadcrumb_path_for "$out_name")"
  [[ -f "$crumb" ]] || return 1

  # Expect a line like: sha=<prefix-or-full>
  local actual
  actual="$(awk -F= '/^sha=/{print $2; exit}' "$crumb" 2>/dev/null || true)"
  [[ -z "$actual" ]] && return 1

  # Accept either full 40-hex or a short prefix.
  if [[ "$actual" == "$expected_sha"* || "$expected_sha" == "$actual"* ]]; then
    return 0
  fi

  return 1
}

write_breadcrumb() {
  local out_name="$1"
  local model="$2"
  local prefix="$3"
  local version="$4"
  local sha="$5"
  local spec_json="$6"

  local crumb_dir crumb
  crumb="$(breadcrumb_path_for "$out_name")"
  crumb_dir="$(dirname "$crumb")"
  mkdir -p "$crumb_dir"

  {
    echo "model=$model"
    echo "prefix=$prefix"
    echo "version=$version"
    echo "sha=$sha"
    echo "spec_json=$spec_json"
    if [[ -n "${UPSTREAM_SHA:-}" ]]; then
      echo "upstream_sha=$UPSTREAM_SHA"
    fi
    echo "generated_at_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  } > "$crumb"
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
#   1) Exact flat filename match (allowing joiners: "", "-", "_")
#   2) Resolve by blob SHA (robust against naming differences) within the model dir
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
  api_id="$model/$prefix@$version"
  is_supported_legacy=0
  if has_flag "$flags_part" "supported_legacy"; then is_supported_legacy=1; fi

  # Honor skip flags.
  if has_flag "$flags_part" "skip_deprecated"; then
    if [[ "$LIST_API_CHANGES" == "1" ]]; then
      emit_api_status "$api_id" "skip_deprecated" "$sha"
    else
      echo "[skip_deprecated] $model/$prefix@$version#$sha"
    fi
    continue
  fi
  if has_flag "$flags_part" "skip_legacy" && ! has_flag "$flags_part" "supported_legacy"; then
    if [[ "$LIST_API_CHANGES" == "1" ]]; then
      emit_api_status "$api_id" "skip_legacy" "$sha"
    else
      echo "[skip_legacy] $model/$prefix@$version#$sha"
    fi
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

  # If we already generated this exact spec (by SHA) into the active lib root, we can skip.
  # This matters most for staged runs where we seed the stage lib from the current lib.
  if [[ "$FORCE" != "1" ]] && breadcrumb_matches "$out_name" "$sha"; then
    if [[ "$LIST_API_CHANGES" == "1" ]]; then
      if [[ "$is_supported_legacy" == "1" ]]; then
        emit_api_status "$api_id" "supported" "$sha"
      else
        emit_api_status "$api_id" "cached" "$sha"
      fi
    else
      if [[ "$DRY_RUN" == "1" ]]; then
        echo "[dry-run] would skip (cached) $model/$prefix@$version#$sha -> $out_dir"
      else
        echo "[skip_cached] $model/$prefix@$version#$sha (matches breadcrumb)"
      fi
    fi
    continue
  fi

  if [[ "$DRY_RUN" == "1" ]]; then
    if [[ "$LIST_API_CHANGES" == "1" ]]; then
      if [[ "$is_supported_legacy" == "1" ]]; then
        emit_api_status "$api_id" "supported" "$sha"
      else
        emit_api_status "$api_id" "dry_run" "$sha"
      fi
    else
      echo "[dry-run] would generate $spec_json -> $out_dir (module=$module_name sha=$sha)"
    fi
  else
    # Compute log file path
    safe_model="${model//[^a-zA-Z0-9]/_}"
    safe_prefix="${prefix//[^a-zA-Z0-9]/_}"
    safe_version="${version//[^a-zA-Z0-9]/_}"
    LOG_FILE="$CODEGEN_LOG_DIR/${safe_model}__${safe_prefix}__${safe_version}.log"
    mkdir -p "$CODEGEN_LOG_DIR"

    if [[ "$LIST_API_CHANGES" == "1" ]]; then
      if [[ "$is_supported_legacy" == "1" ]]; then
        emit_api_status "$api_id" "supported" "$sha"
      else
        emit_api_status "$api_id" "generate" "$sha"
      fi
    else
      echo "[generate] $spec_json -> $out_dir (module=$module_name sha=$sha log=$LOG_FILE)"
    fi
  fi

  if [[ "$DRY_RUN" != "1" ]]; then
    rm -rf "$out_dir"
    mkdir -p "$out_dir"
  fi

  if [[ "$DRY_RUN" != "1" ]]; then
    # Prepare per-gem config.json
    cp "$CONFIG_TEMPLATE" "$out_dir/config.json"
    sed_inplace "s/GEMNAME/${out_name}/g" "$out_dir/config.json"
    sed_inplace "s/MODULENAME/${module_name}/g" "$out_dir/config.json"

    swagger-codegen generate \
      -i "$spec_json" \
      -l ruby \
      -c "$out_dir/config.json" \
      -o "$out_dir" > "$LOG_FILE" 2>&1 || {
        echo "swagger-codegen failed for $model/$prefix@$version (see $LOG_FILE)" >&2
        exit 1
      }

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

    # Record provenance for future cache-skips and debugging.
    write_breadcrumb "$out_name" "$model" "$prefix" "$version" "$sha" "$spec_json"
  fi

done < "$PLAN_FILE"

if [[ "$LIST_API_CHANGES" == "1" ]]; then
  exit 0
fi

if [[ "$DRY_RUN" != "1" && "$STAGE" == "1" ]]; then
  echo "[diff] $FINAL_LIB_ROOT <-> $ACTIVE_LIB_ROOT"

  # Guard: if these ever point at the same directory, the diff output is nonsense.
  if [[ "$(cd "$FINAL_LIB_ROOT" && pwd -P)" == "$(cd "$ACTIVE_LIB_ROOT" && pwd -P)" ]]; then
    echo "Refusing to diff: FINAL_LIB_ROOT and ACTIVE_LIB_ROOT resolve to the same path" >&2
    echo "  FINAL_LIB_ROOT=$FINAL_LIB_ROOT" >&2
    echo "  ACTIVE_LIB_ROOT=$ACTIVE_LIB_ROOT" >&2
    exit 1
  fi

  if [[ "$NAME_ONLY" == "1" ]]; then
    GIT_PAGER=cat git diff --no-index --name-only -- "$FINAL_LIB_ROOT" "$ACTIVE_LIB_ROOT" || true
  else
    GIT_PAGER=cat git diff --no-index -- "$FINAL_LIB_ROOT" "$ACTIVE_LIB_ROOT" || true
  fi

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
