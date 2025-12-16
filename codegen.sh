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

# Hand-maintained entrypoints we must never rewrite.
readonly -a KEEP_FILES=(
  "amz_sp_api.rb"
  "amz_sp_api_version.rb"
)

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
  if [[ "$clobbers" != "0" ]]; then
    _warn "detected ${clobbers} possible clobbers (see ${clob_out})"
  fi

  _note ""
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
  mkdir -p "$LIB_DIR"
  local f
  for f in "${KEEP_FILES[@]}"; do
    if [[ -f "${keep_tmp_dir}/${f}" ]]; then
      mark_seen "${LIB_DIR}/${f}" "restore keep file"
      cp "${keep_tmp_dir}/${f}" "${LIB_DIR}/${f}"
    fi
  done
}

api_module_name() {
  # Convert kebab-case API name into a Ruby ModuleName.
  # Example: "fulfillment-outbound-api-model" -> "FulfillmentOutboundApiModel"
  local api_name="$1"
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
  local spec_file="$1"

  local file_path api_name module_name
  file_path="${spec_file#${MODELS_DIR}/}"
  api_name="${file_path%%/*}"

  # Amazon Seller Central still uses Fulfillment Inbound API v0.
  # The models repo contains both v0 and v1; keep them distinct.
  if [[ "$api_name" == "fulfillment-inbound-api-model" && "$spec_file" == *V0.json ]]; then
    api_name="${api_name}-V0"
  fi

  # Some model folders contain multiple specs (e.g., finances-api-model has multiple json files).
  # If there is more than one spec under the same folder, include the spec basename to avoid
  # clobbering outputs within a single run.
  local spec_basename
  spec_basename="$(basename "$spec_file" .json)"
  local spec_count
  spec_count="$(find "${MODELS_DIR}/${api_name}" -maxdepth 1 -type f -name "*.json" 2>/dev/null | wc -l | tr -d ' ')"
  if [[ "${spec_count}" != "1" ]]; then
    api_name="${api_name}-${spec_basename}"
  fi

  module_name="$(api_module_name "$api_name")"

  rm -rf "${LIB_DIR}/${api_name}"
  mkdir -p "${LIB_DIR}/${api_name}"

  cp "$CONFIG_TEMPLATE" "${LIB_DIR}/${api_name}/${CONFIG_TEMPLATE}"
  mark_seen "${LIB_DIR}/${api_name}/${CONFIG_TEMPLATE}" "${api_name}: cp ${CONFIG_TEMPLATE} (${spec_basename})"

  rewrite_config_placeholders "${LIB_DIR}/${api_name}/${CONFIG_TEMPLATE}" "$api_name" "$module_name"

  local log_file
  log_file="${CODEGEN_LOG_DIR}/${api_name}.swagger-codegen.log"

  echo "Generating ${api_name} (${module_name})"
  echo "  Spec:   ${spec_file}"
  echo "  Output: ${LIB_DIR}/${api_name}"
  echo "  Log:    ${log_file}"

  swagger-codegen generate \
    -i "$spec_file" \
    -l ruby \
    -c "${LIB_DIR}/${api_name}/${CONFIG_TEMPLATE}" \
    -o "${LIB_DIR}/${api_name}" \
    >"$log_file" 2>&1

  if [[ $? -ne 0 ]]; then
    echo "swagger-codegen failed for ${api_name}. Last 50 lines of ${log_file}:" >&2
    tail -n 50 "$log_file" >&2 || true
    exit 1
  fi

  # Hoist the top-level lib entry file and flatten the generated layout.
  mark_seen "${LIB_DIR}/${api_name}.rb" "${api_name}: hoist entry rb (${spec_basename})"
  mv "${LIB_DIR}/${api_name}/lib/${api_name}.rb" "$LIB_DIR/"

  mv "${LIB_DIR}/${api_name}/lib/${api_name}/"* "${LIB_DIR}/${api_name}"

  rm -rf "${LIB_DIR}/${api_name}/lib"
  rm -f "${LIB_DIR}/${api_name}/"*.gemspec

  echo "  Done:   ${api_name}"
}

prepend_provenance_headers() {
  local provenance_header
  provenance_header=$(cat <<EOF
${GENERATED_FROM_PREFIX} ${MODELS_URL}
${REGEN_NOTE}

EOF
)

  local rb tmp
  while IFS= read -r -d '' rb; do
    # Skip hand-maintained entrypoints.
    case "$rb" in
      "${LIB_DIR}/amz_sp_api.rb"|"${LIB_DIR}/amz_sp_api_version.rb")
        continue
        ;;
    esac

    # Avoid double-prepending.
    if head -n 1 "$rb" | grep -qF "$GENERATED_FROM_PREFIX"; then
      continue
    fi

    tmp="${rb}.tmp"
    printf "%s" "$provenance_header" > "$tmp"
    cat "$rb" >> "$tmp"

    mark_seen "$rb" "prepend provenance header"
    mv "$tmp" "$rb"
  done < <(find "$LIB_DIR" -type f -name "*.rb" -print0)
}

record_codegen_artifact() {
  mkdir -p "$(dirname "$CODEGEN_ARTIFACT_FILE")"
  echo "$UPSTREAM_SHA" > "$CODEGEN_ARTIFACT_FILE"
}

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

  # Generate code for each API spec.
  while IFS= read -r -d '' spec; do
    generate_one_api "$spec"
  done < <(find "$MODELS_DIR" -name "*.json" -print0)

  # Ensure hand-maintained entrypoints are present, then annotate generated files.
  restore_keep_files "$KEEP_TMP_DIR"
  prepend_provenance_headers

  # Note: post-generation normalization (hoisting shared runtime) is handled separately by hoist.sh.
  record_codegen_artifact
}

main "$@"
