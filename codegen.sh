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

# Start clean so deletions propagate
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
