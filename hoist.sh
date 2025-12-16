#!/bin/bash
set -euo pipefail

# hoist.sh
# - Hoist shared runtime into top-level lib/
# - Normalize hoisted namespaces so runtime lives under `AmzSpApi`
# - Prepend lightweight provenance headers to generated Ruby files
# - Write CODEGEN_ARTIFACT_FILE so codegen can be skipped deterministically

if [[ ! -f "./env.sh" ]]; then
  echo "Missing ./env.sh. Create it (or restore it) to provide MODELS_DIR/UPSTREAM_SHA and prerequisites." >&2
  exit 1
fi
# shellcheck disable=SC1091
source "./env.sh"

: "${UPSTREAM_SHA:?UPSTREAM_SHA must be set by env.sh}"
: "${MODELS_URL:?MODELS_URL must be set by env.sh}"
: "${CODEGEN_ARTIFACT_FILE:?CODEGEN_ARTIFACT_FILE must be set by env.sh}"
: "${RUNTIME_SOURCE_DIR:?RUNTIME_SOURCE_DIR must be set by env.sh}"

if [[ ! -d "lib" ]]; then
  echo "Missing lib/ directory. Run ./codegen.sh first." >&2
  exit 1
fi

# Prefer gsed on macOS; fall back to sed elsewhere.
SED_BIN="sed"
if command -v gsed >/dev/null 2>&1; then
  SED_BIN="gsed"
fi

# "Constants" (readonly vars)
readonly HOISTED_LIB_DIR="lib"
readonly HOIST_NOTE="# NOTE: Generated and hoisted to lib/ by hoist.sh"
readonly SOURCE_PREFIX="# Source:"
readonly GENERATED_FROM_PREFIX="# NOTE: Generated from"
readonly REGEN_NOTE="# NOTE: If you need to regenerate: ./pull_models.sh && ./codegen.sh"

# Shared runtime files hoisted to top-level lib/
readonly -a HOISTED_RUNTIME_FILES=(
  "api_client.rb"
  "api_error.rb"
  "configuration.rb"
)

# Hand-maintained entrypoints we must never rewrite.
readonly -a HAND_MAINTAINED_FILES=(
  "${HOISTED_LIB_DIR}/amz_sp_api.rb"
  "${HOISTED_LIB_DIR}/amz_sp_api_version.rb"
)

if [[ ! -d "$HOISTED_LIB_DIR" ]]; then
  echo "Missing lib/ directory. Run ./codegen.sh first." >&2
  exit 1
fi

fail() {
  echo "Error: $*" >&2
  exit 1
}

write_header() {
  local src="$1"
  cat <<EOF
${HOIST_NOTE}
${SOURCE_PREFIX} ${src}

EOF
}

normalize_hoisted_runtime_file() {
  local dest="$1"

  # 1) Normalize generator-specific `module AmzSpApi::<ApiModule>` to top-level `module AmzSpApi`.
  "$SED_BIN" -i -E 's/^module AmzSpApi::[A-Za-z0-9_]+$/module AmzSpApi/' "$dest"

  # Ensure we didn't accidentally strip the module.
  if ! grep -qE '^module AmzSpApi(\s|$)' "$dest"; then
    fail "hoisted runtime file is missing 'module AmzSpApi': ${dest}"
  fi

  # 2) In api_client.rb, swagger sometimes resolves return types via a concrete API module.
  # Rewrite to scan AmzSpApi submodules at runtime (best-effort; safe no-op if pattern absent).
  "$SED_BIN" -i -E 's/AmzSpApi::[A-Za-z0-9_]+\.const_get\(return_type\)\.build_from_hash\(data\)/AmzSpApi.constants.map{|c| AmzSpApi.const_get(c)}.select{|sub| sub.kind_of\(Module\)}.detect{|sub| sub.const_defined\(return_type\)}.const_get(return_type).build_from_hash(data)/g' "$dest"
}

hoist_runtime() {
  local name src dest

  for name in "${HOISTED_RUNTIME_FILES[@]}"; do
    src="${RUNTIME_SOURCE_DIR}/${name}"
    dest="${HOISTED_LIB_DIR}/${name}"

    if [[ ! -f "$src" ]]; then
      echo "Warning: ${name} not found in ${RUNTIME_SOURCE_DIR}" >&2
      continue
    fi

    {
      write_header "$src"
      cat "$src"
    } > "$dest"

    normalize_hoisted_runtime_file "$dest"
  done
}

prepend_provenance_headers() {
  # Intentionally lightweight; do not touch hand-maintained files.
  local provenance_header
  provenance_header=$(cat <<EOF
${GENERATED_FROM_PREFIX} ${MODELS_URL}
${REGEN_NOTE}

EOF
)

  local rb tmp
  while IFS= read -r -d '' rb; do
    # Skip hand-maintained entrypoints.
    local hm
    for hm in "${HAND_MAINTAINED_FILES[@]}"; do
      if [[ "$rb" == "$hm" ]]; then
        continue 2
      fi
    done

    # Skip top-level hoisted runtime files (they already carry a hoist note).
    local hr
    for hr in "${HOISTED_RUNTIME_FILES[@]}"; do
      if [[ "$rb" == "${HOISTED_LIB_DIR}/${hr}" ]]; then
        continue 2
      fi
    done

    # Avoid double-prepending.
    if head -n 1 "$rb" | grep -q "^${GENERATED_FROM_PREFIX}"; then
      continue
    fi

    tmp="${rb}.tmp"
    printf "%s" "$provenance_header" > "$tmp"
    cat "$rb" >> "$tmp"
    mv "$tmp" "$rb"
  done < <(find "$HOISTED_LIB_DIR" -type f -name "*.rb" -print0)
}

record_codegen_artifact() {
  echo "$UPSTREAM_SHA" > "$CODEGEN_ARTIFACT_FILE"
}

hoist_runtime
prepend_provenance_headers
record_codegen_artifact
