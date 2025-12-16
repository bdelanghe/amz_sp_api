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

# Hand-maintained entrypoints we must never rewrite.
readonly -a KEEP_FILES=(
  "amz_sp_api.rb"
  "amz_sp_api_version.rb"
)

# Provenance header (comment-only) prepended to generated Ruby files.
readonly GENERATED_FROM_PREFIX="# NOTE: Generated from"
readonly REGEN_NOTE="# NOTE: If you need to regenerate: ./pull_models.sh && ./codegen.sh"

# Require gsed for in-place edits (portable + predictable)
if ! command -v gsed >/dev/null 2>&1; then
  echo "Missing gsed. Install with: brew install gnu-sed" >&2
  exit 1
fi

fail() {
  echo "Error: $*" >&2
  exit 1
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

  module_name="$(api_module_name "$api_name")"

  rm -rf "${LIB_DIR}/${api_name}"
  mkdir -p "${LIB_DIR}/${api_name}"
  cp "$CONFIG_TEMPLATE" "${LIB_DIR}/${api_name}/${CONFIG_TEMPLATE}"

  rewrite_config_placeholders "${LIB_DIR}/${api_name}/${CONFIG_TEMPLATE}" "$api_name" "$module_name"

  swagger-codegen generate \
    -i "$spec_file" \
    -l ruby \
    -c "${LIB_DIR}/${api_name}/${CONFIG_TEMPLATE}" \
    -o "${LIB_DIR}/${api_name}"

  # Hoist the top-level lib entry file and flatten the generated layout.
  mv "${LIB_DIR}/${api_name}/lib/${api_name}.rb" "$LIB_DIR/"
  mv "${LIB_DIR}/${api_name}/lib/${api_name}/"* "${LIB_DIR}/${api_name}"
  rm -rf "${LIB_DIR}/${api_name}/lib"
  rm -f "${LIB_DIR}/${api_name}/"*.gemspec
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

  local keep_tmp_dir
  keep_tmp_dir="$(mktemp -d)"

  cleanup() {
    restore_keep_files "$keep_tmp_dir"
    rm -rf "$keep_tmp_dir"
  }
  trap cleanup EXIT

  stash_keep_files "$keep_tmp_dir"

  rm -rf "$LIB_DIR"
  mkdir -p "$LIB_DIR"

  # Generate code for each API spec.
  while IFS= read -r -d '' spec; do
    generate_one_api "$spec"
  done < <(find "$MODELS_DIR" -name "*.json" -print0)

  # Ensure hand-maintained entrypoints are present, then annotate generated files.
  restore_keep_files "$keep_tmp_dir"
  prepend_provenance_headers

  # Note: post-generation normalization (hoisting shared runtime) is handled separately by hoist.sh.
  record_codegen_artifact
}

main "$@"
