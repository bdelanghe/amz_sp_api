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

# Load models env (produced by pull_models.sh)
if [[ -f "$ROOT_DIR/.models/.env" ]]; then
  # shellcheck disable=SC1091
  source "$ROOT_DIR/.models/.env"
fi

# Optional environment overrides (kept simple / local to the repo).
# This can set PLAN_FILE, MODELS_ROOT, LIB_ROOT, etc.
# Note: env.sh may override values loaded from .models/.env above.
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
DIFF_VIEW=0
FORCE="${FORCE:-0}"
[[ "$FORCE" == "1" ]] || FORCE="0"

# Check modes
CHECK=0
CHECK_STAGED=0
# Check accumulator
CHECK_FAILED=0

# Simple run counters (helps explain no-op runs)
COUNT_GENERATED=0
COUNT_SKIPPED_CACHED=0
COUNT_SKIPPED_LEGACY=0
COUNT_SKIPPED_DEPRECATED=0

# Stage reuse flag: only true when we keep an existing stage for the same plan.
STAGE_REUSED=0

UNKNOWN_ARGS=()


for arg in "$@"; do
  case "$arg" in
    --dry-run|dry-run)
      DRY_RUN=1
      ;;
    --stage|stage)
      STAGE=1
      ;;
    --diff-only|diff-only)
      STAGE=1
      DIFF_ONLY=1
      ;;
    --diff|diff)
      STAGE=1
      DIFF_ONLY=1
      DIFF_VIEW=1
      ;;
    --apply|apply)
      STAGE=1
      APPLY=1
      ;;
    --force|force)
      FORCE=1
      ;;
    --check|check)
      CHECK=1
      ;;
    --check-staged|check-staged)
      CHECK=1
      CHECK_STAGED=1
      ;;
    --check-stagged|check-stagged)
      CHECK=1
      CHECK_STAGED=1
      ;;
    *)
      UNKNOWN_ARGS+=("$arg")
      ;;
  esac
done

if [[ "${#UNKNOWN_ARGS[@]}" -gt 0 ]]; then
  echo "Unknown argument(s): ${UNKNOWN_ARGS[*]}" >&2
  echo "Hint: supported args: stage apply diff-only diff dry-run force check check-staged" >&2
  exit 2
fi


# --check / --check-staged are inspection modes: do not generate, do not stage, do not diff, do not apply.
if [[ "$CHECK" == "1" ]]; then
  DRY_RUN=1
  DIFF_ONLY=0
  APPLY=0

  # Default: check the real lib. If --check-staged was provided, check the staged lib.
  if [[ "$CHECK_STAGED" == "1" ]]; then
    STAGE=1
  else
    STAGE=0
  fi
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

# Which root is being checked (for --check / --check-staged)
CHECK_LIB_ROOT="$FINAL_LIB_ROOT"
if [[ "$CHECK" == "1" && "$CHECK_STAGED" == "1" ]]; then
  CHECK_LIB_ROOT="$ACTIVE_LIB_ROOT"
fi

# Preflight: --check-staged expects a prior staged run to have created $CHECK_LIB_ROOT.
# We intentionally do NOT generate in check mode.
if [[ "$CHECK" == "1" && "$CHECK_STAGED" == "1" ]]; then
  if [[ ! -d "$CHECK_LIB_ROOT" ]]; then
    # Minimal diagnostic (colored when stderr is a TTY)
    if [[ -t 2 && -z "${NO_COLOR:-}" ]]; then
      printf '\033[31m[missing]\033[0m\t%s\n' "$CHECK_LIB_ROOT" >&2
      printf '\033[2m[hint]\033[0m\t%s\n' 'run: ./swagger-codegen.sh stage (or diff-only)' >&2
    else
      printf '[missing]\t%s\n' "$CHECK_LIB_ROOT" >&2
      printf '[hint]\t%s\n' 'run: ./swagger-codegen.sh stage (or diff-only)' >&2
    fi
    exit 1
  fi
fi

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

# If staging and not dry-run, ensure the stage root is ready and created.
# For --stage, only cache-skip if the plan is the same as the previous staged run.
if [[ "$DRY_RUN" != "1" && "$STAGE" == "1" && "$DIFF_VIEW" != "1" ]]; then
  # stage: only keep existing stage (and allow cache-skips) if this is the *same plan* as last stage run.
  # This makes the first `--stage` build, and the second `--stage` cache-skip.
  stage_marker="$STAGE_ROOT/.stage-plan-sha"

  plan_sha=""
  if command -v shasum >/dev/null 2>&1; then
    plan_sha="$(shasum -a 256 "$PLAN_FILE" | awk '{print $1}')"
  elif command -v openssl >/dev/null 2>&1; then
    plan_sha="$(openssl dgst -sha256 "$PLAN_FILE" | awk '{print $2}')"
  fi

  prev_sha=""
  if [[ -f "$stage_marker" ]]; then
    prev_sha="$(cat "$stage_marker" 2>/dev/null || true)"
  fi

  if [[ -d "$STAGE_ROOT/lib" && "$FORCE" != "1" && -n "$plan_sha" && "$prev_sha" == "$plan_sha" ]]; then
    STAGE_REUSED=1
    : # keep existing staged output
  else
    STAGE_REUSED=0
    rm -rf "$STAGE_ROOT"
    mkdir -p "$STAGE_ROOT/lib"
    if [[ -d "$FINAL_LIB_ROOT" ]]; then
      if command -v rsync >/dev/null 2>&1; then
        rsync -a "$FINAL_LIB_ROOT/" "$ACTIVE_LIB_ROOT/"
      else
        cp -a "$FINAL_LIB_ROOT/." "$ACTIVE_LIB_ROOT/"
      fi
    fi
    if [[ -n "$plan_sha" ]]; then
      printf '%s' "$plan_sha" > "$stage_marker"
    fi
  fi
fi
LIB_ROOT="$ACTIVE_LIB_ROOT"

# --diff is a pure inspection mode: it requires an existing staged lib and does not generate.
if [[ "$DIFF_VIEW" == "1" ]]; then
  if [[ ! -d "$ACTIVE_LIB_ROOT" ]]; then
    if [[ -t 2 && -z "${NO_COLOR:-}" ]]; then
      printf '\033[31m[missing]\033[0m\t%s\n' "$ACTIVE_LIB_ROOT" >&2
      printf '\033[2m[hint]\033[0m\t%s\n' 'run: ./swagger-codegen.sh stage' >&2
    else
      printf '[missing]\t%s\n' "$ACTIVE_LIB_ROOT" >&2
      printf '[hint]\t%s\n' 'run: ./swagger-codegen.sh stage' >&2
    fi
    exit 1
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
  local status="$2"       # cached | generate | build | omitted | skip_deprecated | skip_legacy | dry_run | supported
  local sha="$3"          # short or full
  local extra="${4:-}"    # optional extra column (e.g., skip reason)

  # Human-friendly labels
  local label="$status"
  case "$status" in
    cached)          label="cached" ;;
    generate)        label="generate" ;;
    build)           label="build" ;;
    omitted)         label="omitted" ;;
    dry_run)         label="dry_run" ;;
    skip_legacy)     label="outdated" ;;
    skip_deprecated) label="deprecated" ;;
    supported)       label="supported" ;;
  esac

  # Color only the bracketed status token.
  local color_fn=""
  case "$status" in
    cached)           color_fn="c_green" ;;
    omitted)          color_fn="c_green" ;;
    generate)         color_fn="c_yellow" ;;
    build)            color_fn="c_yellow" ;;
    dry_run)          color_fn="c_cyan" ;;
    skip_legacy)      color_fn="c_dim" ;;
    skip_deprecated)  color_fn="c_red" ;;
    supported)        color_fn="c_green" ;;
    *)                color_fn="" ;;
  esac

  # Display SHA like git (short, no `sha=` prefix)
  local sha_tok="$sha"
  if [[ "${#sha_tok}" -gt 12 ]]; then
    sha_tok="${sha_tok:0:12}"
  fi

  # Tab-separated output keeps columns aligned without padding inside brackets.
  # Format:
  #   [status]\t<sha>\t<api>[\t<extra>]
  if [[ -n "$color_fn" ]]; then
    local open close
    open="$($color_fn 2>/dev/null || true)"
    close="$(c_reset 2>/dev/null || true)"
    if [[ -n "$extra" ]]; then
      printf '%s[%s]%s\t%s\t%s\t%s\n' "$open" "$label" "$close" "$sha_tok" "$api" "$extra"
    else
      printf '%s[%s]%s\t%s\t%s\n' "$open" "$label" "$close" "$sha_tok" "$api"
    fi
  else
    if [[ -n "$extra" ]]; then
      printf '[%s]\t%s\t%s\t%s\n' "$label" "$sha_tok" "$api" "$extra"
    else
      printf '[%s]\t%s\t%s\n' "$label" "$sha_tok" "$api"
    fi
  fi
}

emit_run_status() {
  local api="$1"
  local status="$2"
  local sha="$3"
  local extra="${4:-}"
  emit_api_status "$api" "$status" "$sha" "$extra"
}
emit_check_status() {
  local api="$1"     # <model>/<prefix>@<version>
  local status="$2"  # ok | omitted | stale | missing | outdated | deprecated | supported
  local sha="$3"
  local extra="${4:-}"

  local label="$status"
  local color_fn=""
  case "$status" in
    ok)         color_fn="c_green" ;;
    omitted)    color_fn="c_green" ;;
    supported)  color_fn="c_green" ;;
    stale)      color_fn="c_red" ;;
    missing)    color_fn="c_red" ;;
    outdated)   color_fn="c_dim" ;;
    deprecated) color_fn="c_dim" ;;
    *)          color_fn="" ;;
  esac

  local sha_tok="$sha"
  if [[ "${#sha_tok}" -gt 12 ]]; then
    sha_tok="${sha_tok:0:12}"
  fi

  if [[ -n "$color_fn" ]]; then
    local open close
    open="$($color_fn 2>/dev/null || true)"
    close="$(c_reset 2>/dev/null || true)"
    if [[ -n "$extra" ]]; then
      printf '%s[%s]%s\t%s\t%s\t%s\n' "$open" "$label" "$close" "$sha_tok" "$api" "$extra"
    else
      printf '%s[%s]%s\t%s\t%s\n' "$open" "$label" "$close" "$sha_tok" "$api"
    fi
  else
    if [[ -n "$extra" ]]; then
      printf '[%s]\t%s\t%s\t%s\n' "$label" "$sha_tok" "$api" "$extra"
    else
      printf '[%s]\t%s\t%s\n' "$label" "$sha_tok" "$api"
    fi
  fi
}

breadcrumb_actual_sha_at() {
  local root="$1"
  local out_name="$2"

  local crumb
  crumb="$(breadcrumb_path_for_root "$root" "$out_name")"
  [[ -f "$crumb" ]] || return 1

  awk -F= '
    /^json_spec_blob_sha=/{print $2; found=1; exit}
    /^sha=/{print $2; found=1; exit}
    END{if(!found) exit 1}
  ' "$crumb" 2>/dev/null
}

breadcrumb_exists_at() {
  local root="$1"
  local out_name="$2"

  local crumb
  crumb="$(breadcrumb_path_for_root "$root" "$out_name")"
  [[ -f "$crumb" ]]
}

breadcrumb_path_for_root() {
  local root="$1"
  local out_name="$2"
  # Store breadcrumb alongside the generated Ruby module tree.
  echo "$root/$out_name/.codegen-source"
}

breadcrumb_path_for() {
  local out_name="$1"
  breadcrumb_path_for_root "$LIB_ROOT" "$out_name"
}

breadcrumb_path_for_target() {
  local out_name="$1"
  # IMPORTANT: cache decisions should be based on the *target* lib, not the staged copy.
  breadcrumb_path_for_root "$FINAL_LIB_ROOT" "$out_name"
}

breadcrumb_matches_at() {
  local root="$1"
  local out_name="$2"
  local expected_sha="$3"

  # If no expected sha is provided, we can't safely cache-skip.
  [[ -z "$expected_sha" ]] && return 1

  local crumb
  crumb="$(breadcrumb_path_for_root "$root" "$out_name")"
  [[ -f "$crumb" ]] || return 1

  # Try to read json_spec_blob_sha= first, fallback to sha= for backward compatibility.
  local actual
  actual="$(
    awk -F= '
      /^json_spec_blob_sha=/{print $2; found=1; exit}
      /^sha=/{print $2; found=1; exit}
      END{if(!found) exit 1}
    ' "$crumb" 2>/dev/null || true
  )"
  [[ -z "$actual" ]] && return 1

  # Accept either full 40-hex or a short prefix.
  if [[ "$actual" == "$expected_sha"* || "$expected_sha" == "$actual"* ]]; then
    return 0
  fi

  return 1
}

breadcrumb_matches() {
  local out_name="$1"
  local expected_sha="$2"
  breadcrumb_matches_at "$LIB_ROOT" "$out_name" "$expected_sha"
}

breadcrumb_matches_target() {
  local out_name="$1"
  local expected_sha="$2"
  breadcrumb_matches_at "$FINAL_LIB_ROOT" "$out_name" "$expected_sha"
}

# Helper to build a stable upstream URL to the *exact spec blob* that produced this output.
# This is factored out so both write_breadcrumb and check-mode can use it.
build_upstream_spec_url_from_spec_json() {
  local spec_json="$1"

  local upstream_sha_val repo_root_abs spec_abs rel
  local upstream_spec_url=""

  upstream_sha_val="${UPSTREAM_SHA:-${upstream_sha:-}}"
  [[ -z "$upstream_sha_val" ]] && { echo ""; return 0; }

  # MODELS_ROOT points at: <snapshot_root>/models
  # so the snapshot root is: <snapshot_root>
  repo_root_abs="$(cd "$MODELS_ROOT/.." && pwd -P)"

  # Normalize spec_json to an absolute path when possible.
  spec_abs="$spec_json"
  if [[ "$spec_abs" != /* ]]; then
    spec_abs="$(cd "$ROOT_DIR" && perl -MCwd=abs_path -e 'print abs_path(shift)' "$spec_json" 2>/dev/null || true)"
    [[ -n "$spec_abs" ]] || spec_abs="$spec_json"
  fi

  # Preferred: compute path relative to the snapshot git repo root.
  if [[ "$spec_abs" == "$repo_root_abs/"* ]]; then
    rel="${spec_abs#"$repo_root_abs/"}"
  else
    # Fallback: if the path contains `/models/`, derive a repo-relative path starting at `models/`.
    # Example:
    #   .models/df0f6a4/models/aplus-content-api-model/aplusContent_2020-11-01.json
    # becomes:
    #   models/aplus-content-api-model/aplusContent_2020-11-01.json
    if [[ "$spec_json" == *"/models/"* ]]; then
      rel="models/${spec_json#*"/models/"}"
    else
      rel=""
    fi
  fi

  if [[ -n "$rel" ]]; then
    upstream_spec_url="https://github.com/amzn/selling-partner-api-models/blob/${upstream_sha_val}/${rel}"
  fi

  echo "$upstream_spec_url"
}

write_breadcrumb() {
  local out_name="$1"
  local model="$2"
  local prefix="$3"
  local version="$4"
  local sha="$5"
  local spec_json="$6"
  local flags_csv="$7"

  local crumb_dir crumb
  crumb="$(breadcrumb_path_for "$out_name")"
  crumb_dir="$(dirname "$crumb")"
  mkdir -p "$crumb_dir"

  local upstream_spec_url
  upstream_spec_url="$(build_upstream_spec_url_from_spec_json "$spec_json")"

  {
    echo "model=$model"
    echo "prefix=$prefix"
    echo "version=$version"
    echo "json_spec_blob_sha=$sha"
    echo "codegen_flags=${flags_csv:-}"
    echo "upstream_spec_url=$upstream_spec_url"
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

# In check modes, pre-scan the plan so we can explain what a mismatched SHA likely corresponds to.
# This lets us distinguish "minor" (same version, different sha) vs "major" (different version).
# Portable implementation (bash 3.2): write an index file keyed by out_name.
_CHECK_INDEX_FILE=""
if [[ "$CHECK" == "1" ]]; then
  _CHECK_INDEX_FILE="$(mktemp -t swagger_codegen_check_index.XXXXXX)"
  # Ensure cleanup on exit (covers success and failure).
  trap '[[ -n "${_CHECK_INDEX_FILE:-}" && -f "${_CHECK_INDEX_FILE:-}" ]] && rm -f "${_CHECK_INDEX_FILE:-}"' EXIT

  while IFS= read -r _raw; do
    [[ -z "${_raw// }" ]] && continue
    [[ "$_raw" == \#* ]] && continue

    _left="${_raw%%;*}"
    _flags_part=""
    if [[ "$_raw" == *";"* ]]; then
      _flags_part="${_raw#*;}"
      _flags_part="${_flags_part#${_flags_part%%[![:space:]]*}}"
      _flags_part="${_flags_part%${_flags_part##*[![:space:]]}}"
      _flags_part="${_flags_part// /}"
    fi

    _model="${_left%%/*}"
    _rest="${_left#*/}"
    _prefix="${_rest%%@*}"
    _rest2="${_rest#*@}"
    _version="${_rest2%%#*}"
    _sha="${_rest2#*#}"
    _api_id="${_model}/${_prefix}@${_version}"

    _out_name_base="$_model"
    if has_flag "$_flags_part" "use_prefix_namespace"; then
      _out_name_base="${_model}-${_prefix}"
    fi

    _out_name="$_out_name_base"
    if has_flag "$_flags_part" "use_version_namespace"; then
      _ver_tok="$(sanitize_version_token "$_version")"
      _out_name="${_out_name_base}-${_ver_tok}"
    fi

    # Record format: api_id|version|sha|flags
    _rec="${_api_id}|${_version}|${_sha}|${_flags_part}"

    # Index line format: out_name<TAB>record
    printf '%s\t%s\n' "$_out_name" "$_rec" >> "$_CHECK_INDEX_FILE"
  done < "$PLAN_FILE"
fi

check_lookup_plan_record_for_actual_sha() {
  # Given an out_name and an actual sha, return the matching plan record line (api_id|version|sha|flags)
  # when any planned sha matches actual (prefix match in either direction).
  local out_name="$1"
  local actual_sha="$2"

  [[ -n "${_CHECK_INDEX_FILE:-}" && -f "${_CHECK_INDEX_FILE:-}" ]] || return 1

  awk -F'\t' -v key="$out_name" -v actual="$actual_sha" '
    $1 != key { next }
    {
      rec = $2
      n = split(rec, parts, "|")
      plan_sha = parts[3]
      if (plan_sha == "") next
      # prefix match either direction
      if (index(actual, plan_sha) == 1 || index(plan_sha, actual) == 1) {
        print rec
        exit 0
      }
    }
    END { exit 1 }
  ' "$_CHECK_INDEX_FILE"
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
  # Accept either `;flags` or `; flags` (and normalize whitespace).
  left="${raw_line%%;*}"
  flags_part=""
  if [[ "$raw_line" == *";"* ]]; then
    # Everything after the first ';'
    flags_part="${raw_line#*;}"

    # Trim leading/trailing whitespace
    flags_part="${flags_part#${flags_part%%[![:space:]]*}}"
    flags_part="${flags_part%${flags_part##*[![:space:]]}}"

    # Remove all remaining spaces so we can treat it like a CSV
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

  # --check / --check-staged: verify that the chosen lib root matches the plan's expected json_spec_blob_sha.
  # Semantics:
  #   - Non-skipped APIs: breadcrumb must match expected sha (ok/stale/missing)
  #   - Skipped APIs (deprecated/outdated): breadcrumb must be absent (ok if absent, stale if present)
  if [[ "$CHECK" == "1" ]]; then
    # Compute out_name exactly like generation mode so we check the right directory.
    out_name_base="$model"
    if has_flag "$flags_part" "use_prefix_namespace"; then
      out_name_base="${model}-${prefix}"
    fi

    out_name="$out_name_base"
    if has_flag "$flags_part" "use_version_namespace"; then
      ver_tok="$(sanitize_version_token "$version")"
      out_name="${out_name_base}-${ver_tok}"
    fi

    # Skip flags are *assertions* about staleness handling.
    # IMPORTANT: skip_deprecated/skip_legacy entries often share the same out_name as the supported version.
    # In those cases, the directory may legitimately exist (generated by the supported entry).
    # So for skipped entries we only fail if the breadcrumb indicates we generated *that skipped SHA*.
    if has_flag "$flags_part" "skip_deprecated"; then
      if breadcrumb_exists_at "$CHECK_LIB_ROOT" "$out_name"; then
        actual_sha="$(breadcrumb_actual_sha_at "$CHECK_LIB_ROOT" "$out_name" 2>/dev/null || true)"
        # Fail only if the breadcrumb SHA matches the skipped SHA (full or prefix).
        if [[ -n "$actual_sha" && ( "$actual_sha" == "$sha"* || "$sha" == "$actual_sha"* ) ]]; then
          emit_check_status "$api_id" "stale" "$sha" "unexpected_presence actual=${actual_sha:0:12}"
          CHECK_FAILED=1
        else
          # OK: output exists, but it is not from the deprecated SHA (likely overwritten by a supported entry).
          emit_check_status "$api_id" "omitted" "$sha" "skip_deprecated"
        fi
      else
        emit_check_status "$api_id" "omitted" "$sha" "skip_deprecated"
      fi
      continue
    fi

    if has_flag "$flags_part" "skip_legacy" && ! has_flag "$flags_part" "supported_legacy"; then
      if breadcrumb_exists_at "$CHECK_LIB_ROOT" "$out_name"; then
        actual_sha="$(breadcrumb_actual_sha_at "$CHECK_LIB_ROOT" "$out_name" 2>/dev/null || true)"
        # Fail only if the breadcrumb SHA matches the skipped (legacy) SHA (full or prefix).
        if [[ -n "$actual_sha" && ( "$actual_sha" == "$sha"* || "$sha" == "$actual_sha"* ) ]]; then
          emit_check_status "$api_id" "stale" "$sha" "unexpected_presence actual=${actual_sha:0:12}"
          CHECK_FAILED=1
        else
          # OK: output exists, but it is not from the legacy SHA (likely the newest supported version).
          emit_check_status "$api_id" "omitted" "$sha" "skip_legacy"
        fi
      else
        emit_check_status "$api_id" "omitted" "$sha" "skip_legacy"
      fi
      continue
    fi

    if breadcrumb_matches_at "$CHECK_LIB_ROOT" "$out_name" "$sha"; then
      # SHA matches; now validate breadcrumb metadata so we know we're checking the right version.
      crumb_path="$(breadcrumb_path_for_root "$CHECK_LIB_ROOT" "$out_name")"

      actual_model="$(awk -F= '/^model=/{print $2; exit}' "$crumb_path" 2>/dev/null || true)"
      actual_prefix="$(awk -F= '/^prefix=/{print $2; exit}' "$crumb_path" 2>/dev/null || true)"
      actual_version="$(awk -F= '/^version=/{print $2; exit}' "$crumb_path" 2>/dev/null || true)"
      actual_flags="$(awk -F= '/^codegen_flags=/{print $2; exit}' "$crumb_path" 2>/dev/null || true)"
      actual_url="$(awk -F= '/^upstream_spec_url=/{print $2; exit}' "$crumb_path" 2>/dev/null || true)"

      meta_ok=1

      # Model/prefix/version must match the plan entry.
      [[ "$actual_model" == "$model" ]] || meta_ok=0
      [[ "$actual_prefix" == "$prefix" ]] || meta_ok=0
      [[ "$actual_version" == "$version" ]] || meta_ok=0

      # Flags are part of provenance; normalize empty to empty and compare exact.
      [[ "${actual_flags:-}" == "${flags_part:-}" ]] || meta_ok=0

      # upstream_spec_url should be present and (when possible) match what we'd compute.
      expected_url=""
      spec_for_url=""
      spec_for_url="$(find_spec_json "$model" "$prefix" "$version" "$sha" 2>/dev/null || true)"
      if [[ -n "$spec_for_url" ]]; then
        expected_url="$(build_upstream_spec_url_from_spec_json "$spec_for_url")"
      fi

      if [[ -z "$actual_url" ]]; then
        meta_ok=0
      elif [[ -n "$expected_url" && "$actual_url" != "$expected_url" ]]; then
        meta_ok=0
      fi

      if [[ "$meta_ok" == "1" ]]; then
        emit_check_status "$api_id" "ok" "$sha"
      else
        # Keep output compact: mark stale, but include a short reason token.
        reason="meta_mismatch"
        if [[ -z "$actual_url" ]]; then reason="missing_upstream_spec_url"; fi
        if [[ -n "$expected_url" && "$actual_url" != "$expected_url" ]]; then reason="upstream_spec_url_mismatch"; fi
        if [[ "$actual_model" != "$model" || "$actual_prefix" != "$prefix" || "$actual_version" != "$version" ]]; then reason="id_mismatch"; fi
        if [[ "${actual_flags:-}" != "${flags_part:-}" ]]; then reason="flags_mismatch"; fi
        emit_check_status "$api_id" "stale" "$sha" "$reason"
        CHECK_FAILED=1
      fi
    else
      actual="$(breadcrumb_actual_sha_at "$CHECK_LIB_ROOT" "$out_name" 2>/dev/null || true)"
      if [[ -z "$actual" ]]; then
        emit_check_status "$api_id" "missing" "$sha"
      else
        # Try to explain what the actual SHA corresponds to.
        found_rec=""
        found_rec="$(check_lookup_plan_record_for_actual_sha "$out_name" "$actual" 2>/dev/null || true)"

        extra="actual=${actual:0:12}"
        if [[ -n "$found_rec" ]]; then
          found_api="${found_rec%%|*}"
          rest_rec="${found_rec#*|}"
          found_ver="${rest_rec%%|*}"

          if [[ "$found_ver" != "$version" ]]; then
            extra="actual=${actual:0:12} -> ${found_api} (major:version)"
          else
            extra="actual=${actual:0:12} -> ${found_api} (minor:sha)"
          fi
        fi

        emit_check_status "$api_id" "stale" "$sha" "$extra"
      fi
      CHECK_FAILED=1
    fi

    continue
  fi

  # Honor skip flags.
  if has_flag "$flags_part" "skip_deprecated"; then
    if [[ "$STAGE" == "1" ]]; then
      emit_run_status "$api_id" "omitted" "$sha" "skip_deprecated"
    else
      echo "[skip_deprecated] $model/$prefix@$version#$sha"
    fi
    COUNT_SKIPPED_DEPRECATED=$((COUNT_SKIPPED_DEPRECATED + 1))
    continue
  fi
  if has_flag "$flags_part" "skip_legacy" && ! has_flag "$flags_part" "supported_legacy"; then
    if [[ "$STAGE" == "1" ]]; then
      emit_run_status "$api_id" "omitted" "$sha" "skip_legacy"
    else
      echo "[skip_legacy] $model/$prefix@$version#$sha"
    fi
    COUNT_SKIPPED_LEGACY=$((COUNT_SKIPPED_LEGACY + 1))
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

  # Cache-skip rules:
  # - Non-staged runs: cache-skip if FINAL_LIB_ROOT matches (fast, classic behavior).
  # - Staged runs: only cache-skip if we are reusing an existing stage for the same plan,
  #   and the *staged* breadcrumb matches. This guarantees the first `--stage` builds and
  #   the second `--stage` can be cached.
  if [[ "$FORCE" != "1" ]] && {
    if [[ "$STAGE" == "1" ]]; then
      [[ "$STAGE_REUSED" == "1" ]] && breadcrumb_matches_at "$ACTIVE_LIB_ROOT" "$out_name" "$sha"
    else
      breadcrumb_matches_target "$out_name" "$sha"
    fi
  }; then
    if [[ "$STAGE" == "1" ]]; then
      if [[ "$is_supported_legacy" == "1" ]]; then
        emit_run_status "$api_id" "supported" "$sha"
      else
        emit_run_status "$api_id" "cached" "$sha"
      fi
    else
      if [[ "$DRY_RUN" == "1" ]]; then
        echo "[dry-run] would skip (cached) $model/$prefix@$version#$sha -> $out_dir"
      else
        echo "[skip_cached] $model/$prefix@$version#$sha (matches breadcrumb)"
      fi
    fi
    COUNT_SKIPPED_CACHED=$((COUNT_SKIPPED_CACHED + 1))
    continue
  fi

  if [[ "$DRY_RUN" == "1" ]]; then
    echo "[dry-run] would generate $spec_json -> $out_dir (module=$module_name sha=$sha)"
  else
    # Compute log file path
    safe_model="${model//[^a-zA-Z0-9]/_}"
    safe_prefix="${prefix//[^a-zA-Z0-9]/_}"
    safe_version="${version//[^a-zA-Z0-9]/_}"
    LOG_FILE="$CODEGEN_LOG_DIR/${safe_model}__${safe_prefix}__${safe_version}.log"
    mkdir -p "$CODEGEN_LOG_DIR"

    if [[ "$STAGE" == "1" ]]; then
      if [[ "$is_supported_legacy" == "1" ]]; then
        emit_run_status "$api_id" "supported" "$sha"
      else
        emit_run_status "$api_id" "build" "$sha"
      fi
    else
      echo "[generate] $spec_json -> $out_dir (module=$module_name sha=$sha log=$LOG_FILE)"
    fi
    COUNT_GENERATED=$((COUNT_GENERATED + 1))
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
    write_breadcrumb "$out_name" "$model" "$prefix" "$version" "$sha" "$spec_json" "$flags_part"
  fi

done < "$PLAN_FILE"


# Early-exit for check mode
if [[ "$CHECK" == "1" ]]; then
  if [[ "$CHECK_FAILED" == "1" ]]; then
    exit 2
  fi
  exit 0
fi


if [[ "$DRY_RUN" != "1" && "$STAGE" == "1" && ( "$DIFF_ONLY" == "1" || "$APPLY" == "1" ) ]]; then

  # Guard: if these ever point at the same directory, the diff output is nonsense.
  if [[ "$(cd "$FINAL_LIB_ROOT" && pwd -P)" == "$(cd "$ACTIVE_LIB_ROOT" && pwd -P)" ]]; then
    echo "Refusing to diff: FINAL_LIB_ROOT and ACTIVE_LIB_ROOT resolve to the same path" >&2
    echo "  FINAL_LIB_ROOT=$FINAL_LIB_ROOT" >&2
    echo "  ACTIVE_LIB_ROOT=$ACTIVE_LIB_ROOT" >&2
    exit 1
  fi

  # Quiet change detection (git diff --quiet exits 1 when different)
  CHANGED=0
  if ! git diff --no-index --quiet -- "$FINAL_LIB_ROOT" "$ACTIVE_LIB_ROOT" >/dev/null 2>&1; then
    CHANGED=1
  fi

  # Summarize why this may be a no-op run.
  if [[ "$COUNT_GENERATED" == "0" && "$COUNT_SKIPPED_CACHED" -gt 0 ]]; then
    echo "[note] all planned APIs were cache-skipped because $FINAL_LIB_ROOT already matches the plan's json_spec_blob_sha breadcrumbs (use FORCE=1 to regenerate)"
  fi

  if [[ "$DIFF_ONLY" == "1" ]]; then
    GIT_PAGER=cat git diff --no-index -- "$FINAL_LIB_ROOT" "$ACTIVE_LIB_ROOT" || true
  fi

  if [[ "$DIFF_ONLY" == "1" ]]; then
    if [[ "$CHANGED" == "0" ]]; then
      echo "[diff] no changes"
    fi
    echo "[diff-only] not applying staged output"
    exit 0
  fi

  if [[ "$APPLY" == "1" ]]; then
    if [[ "$CHANGED" == "0" ]]; then
      echo "[apply] no changes to apply"
    else
      echo "[apply] promoting staged output into $FINAL_LIB_ROOT"
      rsync -a --delete "$ACTIVE_LIB_ROOT/" "$FINAL_LIB_ROOT/"
      echo "[apply] done"
    fi
  fi
elif [[ "$DRY_RUN" != "1" && "$STAGE" == "1" ]]; then
  echo "[stage] staged output is in $ACTIVE_LIB_ROOT (run with --apply to promote)"
fi
