#!/bin/bash
set -euo pipefail

# codegen.sh
# Generate Ruby client code from pinned Amazon SP-API models.
# Prereqs + contract inputs are provided by ./env.sh.

if [[ ! -f "./env.sh" ]]; then
  echo "Missing ./env.sh. Run from repo root." >&2
  exit 1
fi
# shellcheck disable=SC1091
source "./env.sh"

# Contract inputs (exported by env.sh)
: "${MODELS_DIR:?MODELS_DIR must be set by env.sh}"
: "${UPSTREAM_SHA:?UPSTREAM_SHA must be set by env.sh}"
: "${MODELS_URL:?MODELS_URL must be set by env.sh}"
: "${CODEGEN_ARTIFACT_FILE:?CODEGEN_ARTIFACT_FILE must be set by env.sh}"

FORCE="${FORCE:-0}"

# "Constants" (readonly vars)
readonly LIB_DIR="lib"
readonly CONFIG_TEMPLATE="config.json"
readonly CODEGEN_LOG_DIR=".codegen-logs"
readonly STATUS_TSV_BASENAME="status.tsv"

# Hand-maintained entrypoints we must never rewrite.
readonly -a KEEP_FILES=(
  "amz_sp_api.rb"
  "amz_sp_api_version.rb"
)

# Guard to avoid restoring keep files twice (main flow + EXIT trap)
DID_RESTORE_KEEP_FILES=0

# Provenance header (comment-only) prepended to generated Ruby files.
readonly GENERATED_FROM_PREFIX="# NOTE: Generated from"
readonly REGEN_NOTE="# NOTE: If you need to regenerate: ./pull_models.sh && ./codegen.sh"

fail() {
  echo "Error: $*" >&2
  exit 1
}

# Logging helpers
_color_enabled() {
  [[ -t 2 ]] && command -v tput >/dev/null 2>&1
}

_warn() {
  if _color_enabled; then
    printf "%sWARNING%s: %s\n" "$(tput setaf 1)" "$(tput sgr0)" "$*" >&2
  else
    printf "WARNING: %s\n" "$*" >&2
  fi
}

_note() {
  printf "%s\n" "$*" >&2
}

print_models_context() {
  _note "Models:"
  _note "  SHA:  ${UPSTREAM_SHA}"
  _note "  URL:  ${MODELS_URL}"
  _note "  Dir:  ${MODELS_DIR}"
  _note ""
}

spec_label() {
  # Friendly label for the chosen spec (used in plan output)
  # Prefer basename without .json.
  local spec_path="$1"
  basename "$spec_path" .json
}

status_set() {
  local api="$1"
  local status="$2"

  if [[ -z "${STATUS_TSV:-}" ]]; then
    return 0
  fi

  # Remove any existing line for this api, then append the new status.
  if [[ -f "$STATUS_TSV" ]]; then
    # Use a temp file to stay portable.
    local tmp
    tmp="${STATUS_TSV}.tmp"
    grep -vF "^${api}"$'\t' "$STATUS_TSV" > "$tmp" 2>/dev/null || true
    mv "$tmp" "$STATUS_TSV"
  fi

  printf '%s\t%s\n' "$api" "$status" >> "$STATUS_TSV"
}

status_get() {
  local api="$1"
  local status

  if [[ -z "${STATUS_TSV:-}" || ! -f "$STATUS_TSV" ]]; then
    echo "-"
    return 0
  fi

  status="$(grep -F "^${api}"$'\t' "$STATUS_TSV" | tail -n 1 | cut -f2 || true)"
  if [[ -z "${status}" ]]; then
    echo "-"
  else
    echo "$status"
  fi
}

print_status_table() {
  local plan_tsv="$1"

  _note ""
  _note "API status (api_name -> status):"
  while IFS=$'\t' read -r api_name _module_name _spec _candidate_count; do
    printf '  %-45s -> %s\n' "$api_name" "$(status_get "$api_name")" >&2
  done < "$plan_tsv"
}

should_skip_codegen() {
  # Guard: avoid regenerating when lib/ already matches the current upstream SHA,
  # unless FORCE=1 is explicitly set.
  if [[ -f "$CODEGEN_ARTIFACT_FILE" && "$FORCE" != "1" ]]; then
    local existing_sha
    existing_sha="$(cat "$CODEGEN_ARTIFACT_FILE" 2>/dev/null || true)"
    if [[ "$existing_sha" == "$UPSTREAM_SHA" ]]; then
      echo "${LIB_DIR}/ already generated from ${MODELS_URL}; refusing to re-run codegen without FORCE=1" >&2
      echo "Run: FORCE=1 ./codegen.sh to regenerate anyway" >&2
      return 0
    fi
  fi
  return 1
}

# Seen/clobber tracking
# - Records dest paths we write during a run
# - Warns if we write the same dest path twice (possible clobber)
mark_seen() {
  local dest="$1"
  local src="$2"

  # Directories are expected to be touched multiple times (mkdir, then writes).
  # Only track file-level clobbers.
  if [[ "$dest" == */ ]]; then
    return 0
  fi

  if [[ -z "${SEEN_LIST_FILE:-}" || -z "${CLOBBER_LIST_FILE:-}" ]]; then
    return 0
  fi

  if grep -qF "${dest}"$'\t' "$SEEN_LIST_FILE" 2>/dev/null; then
    local prev
    prev="$(grep -F "${dest}"$'\t' "$SEEN_LIST_FILE" | head -n 1 | cut -f2- || true)"

    _warn "possible clobber: ${dest}"
    _note "  prev: ${prev}"
    _note "  new:  ${src}"
    printf '%s\t%s\n' "$dest" "${prev} -> ${src}" >> "$CLOBBER_LIST_FILE"
  else
    printf '%s\t%s\n' "$dest" "$src" >> "$SEEN_LIST_FILE"
  fi
}

seen_summary() {
  local seen_out clob_out
  seen_out="${CODEGEN_LOG_DIR}/seen.tsv"
  clob_out="${CODEGEN_LOG_DIR}/clobbers.tsv"

  cp "$SEEN_LIST_FILE" "$seen_out" 2>/dev/null || true
  cp "$CLOBBER_LIST_FILE" "$clob_out" 2>/dev/null || true

  local clobbers
  clobbers="$(wc -l < "$CLOBBER_LIST_FILE" 2>/dev/null || echo 0)"

  # Be silent on the happy path.
  if [[ "$clobbers" == "0" ]]; then
    return 0
  fi

  _warn "detected ${clobbers} possible clobbers (see ${clob_out})"
  _note "Seen list written to: ${seen_out}"
}

stash_keep_files() {
  local keep_tmp_dir="$1"
  mkdir -p "$keep_tmp_dir"
  local f
  for f in "${KEEP_FILES[@]}"; do
    if [[ -f "${LIB_DIR}/${f}" ]]; then
      cp "${LIB_DIR}/${f}" "${keep_tmp_dir}/${f}"
    fi
  done
}

restore_keep_files() {
  local keep_tmp_dir="$1"
  if [[ "${DID_RESTORE_KEEP_FILES}" == "1" ]]; then
    return 0
  fi
  mkdir -p "$LIB_DIR"
  local f
  for f in "${KEEP_FILES[@]}"; do
    if [[ -f "${keep_tmp_dir}/${f}" ]]; then
      mark_seen "${LIB_DIR}/${f}" "restore keep file"
      cp "${keep_tmp_dir}/${f}" "${LIB_DIR}/${f}"
    fi
  done
  DID_RESTORE_KEEP_FILES=1
}

api_module_name() {
  # Convert kebab-case API name into a Ruby ModuleName.
  # Example: "fulfillment-outbound-api-model" -> "FulfillmentOutboundApiModel"
  local api_name="$1"

  # If we split an API into a V0 variant at plan-time (e.g. fulfillment-inbound-api-model-V0),
  # keep the module name stable and explicit.
  if [[ "$api_name" == *"-V0" ]]; then
    local base
    base="${api_name%-V0}"
    printf '%sV0\n' "$(echo "$base" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g')"
    return 0
  fi

  echo "$api_name" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g'
}

rewrite_config_placeholders() {
  local config_path="$1"
  local api_name="$2"
  local module_name="$3"

  gsed -i "s/GEMNAME/${api_name}/g" "$config_path"
  gsed -i "s/MODULENAME/${module_name}/g" "$config_path"
}

generate_one_api() {
  local api_name="$1"
  local module_name="$2"
  local spec_file="$3"

  local spec_basename
  spec_basename="$(basename "$spec_file" .json)"

  rm -rf "${LIB_DIR}/${api_name}"
  mkdir -p "${LIB_DIR}/${api_name}"

  cp "$CONFIG_TEMPLATE" "${LIB_DIR}/${api_name}/${CONFIG_TEMPLATE}"
  mark_seen "${LIB_DIR}/${api_name}/${CONFIG_TEMPLATE}" "${api_name}: cp ${CONFIG_TEMPLATE} (${spec_basename})"

  rewrite_config_placeholders "${LIB_DIR}/${api_name}/${CONFIG_TEMPLATE}" "$api_name" "$module_name"

  local log_file
  log_file="${CODEGEN_LOG_DIR}/${api_name}.swagger-codegen.log"

  status_set "$api_name" "RUN"

  echo "Generating ${api_name} -> ${spec_basename}"

  if ! swagger-codegen generate \
    -i "$spec_file" \
    -l ruby \
    -c "${LIB_DIR}/${api_name}/${CONFIG_TEMPLATE}" \
    -o "${LIB_DIR}/${api_name}" \
    >"$log_file" 2>&1; then
    status_set "$api_name" "FAIL"
    _warn "swagger-codegen failed for ${api_name} (see ${log_file})"
    _note "Last 50 lines:"
    tail -n 50 "$log_file" >&2 || true
    exit 1
  fi

  # Hoist the top-level lib entry file and flatten the generated layout.
  mark_seen "${LIB_DIR}/${api_name}.rb" "${api_name}: hoist entry rb (${spec_basename})"
  mv "${LIB_DIR}/${api_name}/lib/${api_name}.rb" "$LIB_DIR/"

  mv "${LIB_DIR}/${api_name}/lib/${api_name}/"* "${LIB_DIR}/${api_name}"

  rm -rf "${LIB_DIR}/${api_name}/lib"
  rm -f "${LIB_DIR}/${api_name}/"*.gemspec

  status_set "$api_name" "OK"

  echo "Done: ${api_name}"
}

prepend_provenance_headers() {
  local plan_tsv="$1"

  local rb tmp
  while IFS= read -r -d '' rb; do
    # Skip hand-maintained entrypoints.
    case "$rb" in
      "${LIB_DIR}/amz_sp_api.rb"|"${LIB_DIR}/amz_sp_api_version.rb")
        continue
        ;;
    esac

    # Determine API folder name from the lib path.
    # - lib/<api>.rb => <api>
    # - lib/<api>/*  => <api>
    local rel api selected_spec candidate_count spec_basename
    rel="${rb#${LIB_DIR}/}"
    api="${rel%%/*}"
    api="${api%.rb}"

    selected_spec="$(grep -F "^${api}"$'\t' "$plan_tsv" | head -n 1 | cut -f3 || true)"
    candidate_count="$(grep -F "^${api}"$'\t' "$plan_tsv" | head -n 1 | cut -f4 || true)"

    spec_basename=""
    if [[ -n "$selected_spec" ]]; then
      spec_basename="$(basename "$selected_spec")"
    fi

    local provenance_header
    provenance_header=$(cat <<EOF
${GENERATED_FROM_PREFIX} ${MODELS_URL}
# NOTE: Spec: ${spec_basename}
# NOTE: Spec candidates: ${candidate_count}
${REGEN_NOTE}

EOF
)

    # Avoid double-prepending.
    if head -n 1 "$rb" | grep -qF "$GENERATED_FROM_PREFIX"; then
      continue
    fi

    tmp="${rb}.tmp"
    printf "%s" "$provenance_header" > "$tmp"
    cat "$rb" >> "$tmp"

    mv "$tmp" "$rb"
  done < <(find "$LIB_DIR" -type f -name "*.rb" -print0)
}

record_codegen_artifact() {
  mkdir -p "$(dirname "$CODEGEN_ARTIFACT_FILE")"
  echo "$UPSTREAM_SHA" > "$CODEGEN_ARTIFACT_FILE"
}

record_codegen_plan() {
  local plan_tsv="$1"

  # Persist a stable plan for diffs/review.
  # Kept under lib/ so it versions alongside generated artifacts.
  cp "$plan_tsv" "${LIB_DIR}/.codegen_plan.tsv"

  if [[ -s "${CODEGEN_LOG_DIR}/duplicates.tsv" ]]; then
    cp "${CODEGEN_LOG_DIR}/duplicates.tsv" "${LIB_DIR}/.codegen_plan_duplicates.tsv"
  else
    rm -f "${LIB_DIR}/.codegen_plan_duplicates.tsv" 2>/dev/null || true
  fi
}

build_generation_plan() {
  mkdir -p "$CODEGEN_LOG_DIR"

  local all_specs selected_specs plan_tsv
  all_specs="${CODEGEN_LOG_DIR}/.all_specs.tsv"
  selected_specs="${CODEGEN_LOG_DIR}/.selected_specs.tsv"
  plan_tsv="${CODEGEN_LOG_DIR}/.plan.tsv"

  local duplicates_tsv
  duplicates_tsv="${CODEGEN_LOG_DIR}/duplicates.tsv"

  : > "$all_specs"

  # Collect: api_name <TAB> spec_path
  while IFS= read -r -d '' spec; do
    local rel api base
    rel="${spec#${MODELS_DIR}/}"
    api="${rel%%/*}"

    # Plan-time split: Seller Central still uses Fulfillment Inbound V0.
    # Treat V0 as a distinct API so we generate both without ambiguity.
    if [[ "$api" == "fulfillment-inbound-api-model" && "$(basename "$spec")" == *V0.json ]]; then
      api="${api}-V0"
    fi

    printf '%s\t%s\n' "$api" "$spec" >> "$all_specs"
  done < <(find "$MODELS_DIR" -name "*.json" -print0)

  # Detect APIs with multiple specs.
  : > "$duplicates_tsv"
  LC_ALL=C cut -f1 "$all_specs" | sort | uniq -c | awk '$1 > 1 {print $2 "\t" $1}' > "${CODEGEN_LOG_DIR}/.dup_counts.tsv"

  if [[ -s "${CODEGEN_LOG_DIR}/.dup_counts.tsv" ]]; then
    while IFS=$'\t' read -r api cnt; do
      # list candidates (basenames)
      cands="$(grep -F "$api"$'\t' "$all_specs" | cut -f2 | xargs -n1 basename | tr '\n' ',' | sed 's/,$//')"
      printf '%s\t%s\t%s\n' "$api" "$cnt" "$cands" >> "$duplicates_tsv"
    done < "${CODEGEN_LOG_DIR}/.dup_counts.tsv"
  fi

  rm -f "${CODEGEN_LOG_DIR}/.dup_counts.tsv"

  # Select exactly one spec per api folder.
  # Preference order:
  #  1) Highest YYYY-MM-DD date found in filename (newest wins)
  #  2) Otherwise, prefer V0.json (fallback)
  #  3) Otherwise, last filename in sort order
  LC_ALL=C sort -t $'\t' -k1,1 -k2,2 "$all_specs" | awk -F'\t' '
    function date_score(p,   d) {
      # extract first YYYY-MM-DD in the path; return as integer YYYYMMDD
      if (match(p, "[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]")) {
        d = substr(p, RSTART, RLENGTH);
        gsub("-", "", d);
        return d + 0;
      }
      return 0;
    }

    function spec_score(p,   s, d) {
      # Prefer dated specs; V0 is fallback only when no dated spec exists.
      d = date_score(p);
      s = d;
      if (p ~ /V0\.json$/ && d == 0) {
        s = -1;
      }
      return s;
    }

    {
      api = $1; p = $2;
      if (api != cur) {
        if (cur != "") print cur "\t" best;
        cur = api;
        best = p;
        bests = spec_score(p);
      } else {
        s = spec_score(p);
        if (s > bests) {
          best = p;
          bests = s;
        } else if (s == bests) {
          # tie-breaker: later filename wins (we are in sorted order)
          best = p;
        }
      }
    }
    END { if (cur != "") print cur "\t" best; }
  ' > "$selected_specs"

  : > "$plan_tsv"
  while IFS=$'\t' read -r api spec; do
    mod="$(api_module_name "$api")"
    cnt="$(grep -cF "$api"$'\t' "$all_specs" 2>/dev/null || echo 1)"
    printf '%s\t%s\t%s\t%s\n' "$api" "$mod" "$spec" "$cnt" >> "$plan_tsv"
  done < "$selected_specs"

  echo "$plan_tsv"
}

print_generation_plan() {
  local plan_tsv="$1"

  print_models_context

  local count
  count="$(wc -l < "$plan_tsv" | tr -d ' ')"
  _note "Generation plan:"
  _note "  APIs: ${count}"
  _note ""

  _note "API selections (api_name -> spec [candidates] status):"
  while IFS=$'\t' read -r api_name _module_name spec candidate_count; do
    printf '  %-45s -> %-35s [%s] %s\n' "$api_name" "$(spec_label "$spec")" "${candidate_count}" "$(status_get "$api_name")" >&2
  done < "$plan_tsv"

  _note ""
  _note "Notes: provenance headers are applied after generation (expected rewrite)."
  if [[ -s "${CODEGEN_LOG_DIR}/duplicates.tsv" ]]; then
    _note "Duplicates (if any) are written to: ${CODEGEN_LOG_DIR}/duplicates.tsv"
  fi
}


# Argument parsing
APPLY=0
for arg in "$@"; do
  if [[ "$arg" == "--apply" ]]; then
    APPLY=1
  fi
done

# --apply: promote already-staged output into lib (no plan, no cache, no diff)
if [[ "${APPLY:-0}" == "1" ]]; then
  STAGE_LIB_DIR="${STAGE_LIB_DIR:-.codegen-stage/lib}"
  LIB_ROOT="${LIB_ROOT:-lib}"

  if [[ ! -d "$STAGE_LIB_DIR" ]]; then
    echo "Missing staged output dir: $STAGE_LIB_DIR (run ./swagger-codegen.sh first to stage output)" >&2
    exit 1
  fi

  echo "[apply] promoting staged output into $LIB_ROOT"
  mkdir -p "$LIB_ROOT"

  # Copy staged lib -> lib, deleting files in lib that are no longer present in stage.
  rsync -a --delete "$STAGE_LIB_DIR/" "$LIB_ROOT/"

  echo "[apply] done"
  exit 0
fi

main() {
  if should_skip_codegen; then
    exit 1
  fi

  # NOTE: keep_tmp_dir must not be `local` because the EXIT trap can fire after
  # `main` returns; with `set -u`, that would make the variable "unbound".
  KEEP_TMP_DIR="$(mktemp -d)"

  cleanup() {
    if [[ -n "${KEEP_TMP_DIR:-}" && -d "${KEEP_TMP_DIR}" ]]; then
      restore_keep_files "$KEEP_TMP_DIR"
      rm -rf "$KEEP_TMP_DIR"
    fi

    if [[ -n "${SEEN_LIST_FILE:-}" && -f "${SEEN_LIST_FILE}" ]]; then
      seen_summary || true
    fi
  }
  trap cleanup EXIT

  stash_keep_files "$KEEP_TMP_DIR"

  rm -rf "$LIB_DIR"
  mkdir -p "$LIB_DIR"

  rm -rf "$CODEGEN_LOG_DIR"
  mkdir -p "$CODEGEN_LOG_DIR"

  # Initialize seen/clobber lists.
  SEEN_LIST_FILE="${CODEGEN_LOG_DIR}/.seen.tmp.tsv"
  CLOBBER_LIST_FILE="${CODEGEN_LOG_DIR}/.clobbers.tmp.tsv"
  : > "$SEEN_LIST_FILE"
  : > "$CLOBBER_LIST_FILE"

  STATUS_TSV="${CODEGEN_LOG_DIR}/${STATUS_TSV_BASENAME}"
  : > "$STATUS_TSV"

  # Precompute a stable plan so API_NAME/MODULE_NAME are deterministic and match upstream.
  local plan_tsv
  plan_tsv="$(build_generation_plan)"
  print_generation_plan "$plan_tsv"

  while IFS=$'\t' read -r api_name _module_name _spec _candidate_count; do
    status_set "$api_name" "PLANNED"
  done < "$plan_tsv"

  # Re-print selections now that statuses are initialized.
  _note ""
  _note "API selections (api_name -> spec [candidates] status):"
  while IFS=$'\t' read -r api_name _module_name spec candidate_count; do
    printf '  %-45s -> %-35s [%s] %s\n' "$api_name" "$(spec_label "$spec")" "${candidate_count}" "$(status_get "$api_name")" >&2
  done < "$plan_tsv"

  _note ""

  while IFS=$'\t' read -r api_name module_name spec candidate_count; do
    generate_one_api "$api_name" "$module_name" "$spec"
    echo "Status: ${api_name} -> $(status_get "$api_name")"
  done < "$plan_tsv"

  print_status_table "$plan_tsv"

  # Ensure hand-maintained entrypoints are present, then annotate generated files.
  restore_keep_files "$KEEP_TMP_DIR"
  prepend_provenance_headers "$plan_tsv"
  record_codegen_plan "$plan_tsv"

  # Note: post-generation normalization (hoisting shared runtime) is handled separately by hoist.sh.
  record_codegen_artifact
}

main "$@"
