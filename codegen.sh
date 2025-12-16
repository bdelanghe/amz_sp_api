#!/bin/bash
set -euo pipefail

MODELS_DIR="${MODELS_DIR:-}"
UPSTREAM_SHA="${UPSTREAM_SHA:-}"

# Source repo-local models env if needed
if [[ -z "$MODELS_DIR" || -z "$UPSTREAM_SHA" ]]; then
  if [[ -f ".models/.env" ]]; then
    # shellcheck disable=SC1091
    source ".models/.env"
  else
    echo "Missing .models/.env." >&2
    echo "Run ./pull_models.sh first." >&2
    exit 1
  fi
fi

# Validate inputs
if [[ -z "$MODELS_DIR" || -z "$UPSTREAM_SHA" ]]; then
  echo "MODELS_DIR or UPSTREAM_SHA not set after sourcing .models/.env" >&2
  exit 1
fi


if [[ ! -d "$MODELS_DIR" ]]; then
  echo "MODELS_DIR is not a directory: '$MODELS_DIR'" >&2
  exit 1
fi

MODELS_URL="https://github.com/amzn/selling-partner-api-models/tree/${UPSTREAM_SHA}/models"
CODEGEN_ARTIFACT_FILE="lib/.codegen_models_sha"

# Skip if we've already generated lib/ for this upstream SHA
if [[ -f "$CODEGEN_ARTIFACT_FILE" ]]; then
  existing_sha="$(cat "$CODEGEN_ARTIFACT_FILE" 2>/dev/null || true)"
  if [[ "$existing_sha" == "$UPSTREAM_SHA" ]]; then
    echo "lib/ already generated from ${MODELS_URL}; skipping codegen" >&2
    exit 0
  fi
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

# Generate safely; fail fast; handle spaces
while IFS= read -r -d '' FILE; do
  FILE_PATH="${FILE#$MODELS_DIR/}"
  API_NAME="${FILE_PATH%%/*}"

  # Amazon Seller Central still uses Fulfillment Inbound API v0.
  if [[ "$API_NAME" == "fulfillment-inbound-api-model" && "$FILE" == *V0.json ]]; then
    API_NAME="${API_NAME}-V0"
  fi

  MODULE_NAME="$(echo "$API_NAME" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g')"

  rm -rf "lib/${API_NAME}"
  mkdir -p "lib/${API_NAME}"
  cp config.json "lib/${API_NAME}/config.json"

  if sed --version >/dev/null 2>&1; then
    sed -i "s/GEMNAME/${API_NAME}/g" "lib/${API_NAME}/config.json"
    sed -i "s/MODULENAME/${MODULE_NAME}/g" "lib/${API_NAME}/config.json"
  else
    sed -i '' "s/GEMNAME/${API_NAME}/g" "lib/${API_NAME}/config.json"
    sed -i '' "s/MODULENAME/${MODULE_NAME}/g" "lib/${API_NAME}/config.json"
  fi

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

# Copy common runtime files into top-level lib/ from the first generated module
FIRST_MODULE_DIR="$(find lib -mindepth 1 -maxdepth 1 -type d | LC_ALL=C sort | head -n 1 || true)"

if [[ -z "$FIRST_MODULE_DIR" ]]; then
  echo "Warning: no generated modules found under lib/" >&2
else
  COMMON_FILES=("api_client.rb" "api_error.rb" "configuration.rb")
  for name in "${COMMON_FILES[@]}"; do
    src="${FIRST_MODULE_DIR}/${name}"
    dest="lib/$name"
    if [[ -f "$src" ]]; then
      {
        echo "# NOTE: This file is generated and hoisted to lib/ by codegen.sh"
        echo "# Source: ${src}"
        echo
        cat "$src"
      } > "$dest"
    else
      echo "Warning: ${name} not found in ${FIRST_MODULE_DIR}" >&2
    fi
  done
fi

# Record provenance so we can skip re-running codegen for the same upstream SHA
mkdir -p lib
echo "$UPSTREAM_SHA" > "$CODEGEN_ARTIFACT_FILE"

# Add a short provenance note to the top of generated Ruby files.
# This is intentionally lightweight and avoids editing hand-maintained files.
PROVENANCE_HEADER="# NOTE: Generated from ${MODELS_URL}\n# NOTE: If you need to regenerate: ./pull_models.sh && ./codegen.sh\n\n"
while IFS= read -r -d '' rb; do
  base="$(basename "$rb")"

  # Skip hand-maintained and already-hoisted runtime files (they already carry a note)
  if [[ "$base" == "amz_sp_api.rb" || "$base" == "amz_sp_api_version.rb" ]]; then
    continue
  fi
  if [[ "$base" == "api_client.rb" || "$base" == "api_error.rb" || "$base" == "configuration.rb" ]]; then
    continue
  fi

  # Avoid double-prepending if run manually
  if head -n 1 "$rb" | grep -q "^# NOTE: Generated from https://github.com/amzn/selling-partner-api-models/tree/"; then
    continue
  fi

  tmp="${rb}.tmp"
  printf "%b" "$PROVENANCE_HEADER" > "$tmp"
  cat "$rb" >> "$tmp"
  mv "$tmp" "$rb"
done < <(find lib -type f -name "*.rb" -print0)
