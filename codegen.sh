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

# Copy common runtime files into top-level lib/ (take the first match deterministically)
COMMON_FILES=("api_client.rb" "api_error.rb" "configuration.rb")
for name in "${COMMON_FILES[@]}"; do
  src="$(find lib -type f -name "$name" ! -path "lib/$name" 2>/dev/null | LC_ALL=C sort | head -n 1 || true)"
  if [[ -n "$src" ]]; then
    cp "$src" "lib/$name"
  else
    echo "Warning: could not find $name under lib/ (generated output)" >&2
  fi
done
