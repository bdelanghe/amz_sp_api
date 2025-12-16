#!/bin/bash
set -euo pipefail

# Generate Ruby client code from pinned Amazon SP-API models.
# Environment + prerequisites are enforced by env.sh.

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
: "${RUNTIME_SOURCE_DIR:?RUNTIME_SOURCE_DIR must be set by env.sh}"
FORCE="${FORCE:-0}"

# Guard: code generation is destructive/expensive; require explicit FORCE=1.
if [[ "$FORCE" != "1" ]]; then
  echo "Refusing to run codegen without FORCE=1" >&2
  echo "Run: FORCE=1 ./codegen.sh" >&2
  exit 1
fi

# Start clean so deletions propagate, but preserve a couple hand-maintained files.
KEEP_FILES=("amz_sp_api.rb" "amz_sp_api_version.rb")

KEEP_TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$KEEP_TMP_DIR"' EXIT

for f in "${KEEP_FILES[@]}"; do
  if [[ -f "lib/$f" ]]; then
    cp "lib/$f" "$KEEP_TMP_DIR/$f"
  fi
done

rm -rf lib
mkdir -p lib

# Generate code for each API spec
while IFS= read -r -d '' FILE; do
  FILE_PATH="${FILE#$MODELS_DIR/}"
  API_NAME="${FILE_PATH%%/*}"

  # Amazon Seller Central still uses Fulfillment Inbound API v0.
  # The models repo contains both v0 and v1; keep them distinct.
  if [[ "$API_NAME" == "fulfillment-inbound-api-model" && "$FILE" == *V0.json ]]; then
    API_NAME="${API_NAME}-V0"
  fi

  MODULE_NAME="$(echo "$API_NAME" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g')"

  rm -rf "lib/${API_NAME}"
  mkdir -p "lib/${API_NAME}"
  cp config.json "lib/${API_NAME}/config.json"

  gsed -i "s/GEMNAME/${API_NAME}/g" "lib/${API_NAME}/config.json"
  gsed -i "s/MODULENAME/${MODULE_NAME}/g" "lib/${API_NAME}/config.json"

  swagger-codegen generate \
    -i "$FILE" \
    -l ruby \
    -c "lib/${API_NAME}/config.json" \
    -o "lib/${API_NAME}"

  mv "lib/${API_NAME}/lib/${API_NAME}.rb" lib/
  mv "lib/${API_NAME}/lib/${API_NAME}/"* "lib/${API_NAME}"
  rm -rf "lib/${API_NAME}/lib"
  rm -f "lib/${API_NAME}/"*.gemspec
done < <(find "$MODELS_DIR" -name "*.json" -print0)

# Restore preserved files (if they existed before cleanup)
for f in "${KEEP_FILES[@]}"; do
  if [[ -f "$KEEP_TMP_DIR/$f" ]]; then
    cp "$KEEP_TMP_DIR/$f" "lib/$f"
  fi
done

# Note: post-generation normalization (hoisting + provenance headers)
# is handled separately by hoist.sh.
