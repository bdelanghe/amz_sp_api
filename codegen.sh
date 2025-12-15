#!/bin/bash

# exit on error
set -euo pipefail

MODELS_REF="${MODELS_REF:-main}"
MODELS_REPO="$(git remote get-url upstream)"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

git clone --depth 1 --branch "$MODELS_REF" "$MODELS_REPO" "$TMP_DIR"

MODELS_DIR="$TMP_DIR/models"

# start clean so deletions propagate
rm -rf lib
mkdir -p lib

for FILE in $(find "$MODELS_DIR" -name "*.json"); do
  API_NAME=$(echo "$FILE" | awk -F/ '{print $4}')

  # Amazon Seller Central still uses Fulfillment Inbound API v0.
  # https://developer-docs.amazon.com/sp-api/docs/fulfillment-inbound-api-v0-reference
  if [[ "$API_NAME" == "fulfillment-inbound-api-model" && "$FILE" == *V0.json ]]; then
    API_NAME="${API_NAME}-V0"
  fi

  MODULE_NAME=$(echo "$API_NAME" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g')

  rm -rf "lib/${API_NAME}"
  mkdir -p "lib/${API_NAME}"
  cp config.json "lib/${API_NAME}/config.json"

  # GNU sed (Linux): sed -i "..."
  # BSD sed (macOS): sed -i '' "..."
  if sed --version >/dev/null 2>&1; then
    sed -i "s/GEMNAME/${API_NAME}/g" "lib/${API_NAME}/config.json"
    sed -i "s/MODULENAME/${MODULE_NAME}/g" "lib/${API_NAME}/config.json"
  else
    sed -i '' "s/GEMNAME/${API_NAME}/g" "lib/${API_NAME}/config.json"
    sed -i '' "s/MODULENAME/${MODULE_NAME}/g" "lib/${API_NAME}/config.json"
  fi

  swagger-codegen generate -i "$FILE" -l ruby -c "lib/${API_NAME}/config.json" -o "lib/${API_NAME}"

  mv "lib/${API_NAME}/lib/${API_NAME}.rb" lib/
  mv "lib/${API_NAME}/lib/${API_NAME}/"* "lib/${API_NAME}"
  rm -rf "lib/${API_NAME}/lib"
  rm -f "lib/${API_NAME}/"*.gemspec
done

if ! git diff --cached --quiet; then
  git commit -m "Generated from selling-partner-api-models@${UPSTREAM_SHA}"
fi

# Resolve the exact upstream commit we used
UPSTREAM_SHA="$(cd "$TMP_DIR" && git rev-parse HEAD)"
UPSTREAM_SHORT_SHA="${UPSTREAM_SHA:0:7}"

#!/bin/bash

# exit on error
set -euo pipefail

MODELS_REF="${MODELS_REF:-main}"
MODELS_REPO="$(git remote get-url upstream)"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

git clone --depth 1 --branch "$MODELS_REF" "$MODELS_REPO" "$TMP_DIR"

MODELS_DIR="$TMP_DIR/models"

# start clean so deletions propagate
rm -rf lib
mkdir -p lib

for FILE in $(find "$MODELS_DIR" -name "*.json"); do
  API_NAME=$(echo "$FILE" | awk -F/ '{print $4}')

  # Amazon Seller Central still uses Fulfillment Inbound API v0.
  # https://developer-docs.amazon.com/sp-api/docs/fulfillment-inbound-api-v0-reference
  if [[ "$API_NAME" == "fulfillment-inbound-api-model" && "$FILE" == *V0.json ]]; then
    API_NAME="${API_NAME}-V0"
  fi

  MODULE_NAME=$(echo "$API_NAME" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g')

  rm -rf "lib/${API_NAME}"
  mkdir -p "lib/${API_NAME}"
  cp config.json "lib/${API_NAME}/config.json"

  # GNU sed (Linux): sed -i "..."
  # BSD sed (macOS): sed -i '' "..."
  if sed --version >/dev/null 2>&1; then
    sed -i "s/GEMNAME/${API_NAME}/g" "lib/${API_NAME}/config.json"
    sed -i "s/MODULENAME/${MODULE_NAME}/g" "lib/${API_NAME}/config.json"
  else
    sed -i '' "s/GEMNAME/${API_NAME}/g" "lib/${API_NAME}/config.json"
    sed -i '' "s/MODULENAME/${MODULE_NAME}/g" "lib/${API_NAME}/config.json"
  fi

  swagger-codegen generate -i "$FILE" -l ruby -c "lib/${API_NAME}/config.json" -o "lib/${API_NAME}"

  mv "lib/${API_NAME}/lib/${API_NAME}.rb" lib/
  mv "lib/${API_NAME}/lib/${API_NAME}/"* "lib/${API_NAME}"
  rm -rf "lib/${API_NAME}/lib"
  rm -f "lib/${API_NAME}/"*.gemspec
done

# Resolve the exact upstream commit we used
UPSTREAM_SHA="$(cd "$TMP_DIR" && git rev-parse HEAD)"
TAG_NAME="upstream/selling-partner-api-models/${UPSTREAM_SHA:0:7}"

# Commit only if something changed
git add lib
git diff --cached --quiet || \
  git commit -m "Generated from selling-partner-api-models@${UPSTREAM_SHA}"

# Move (or create) an annotated tag pointing at current HEAD
git tag -f -a "$TAG_NAME" \
  -m "Generated from selling-partner-api-models@${UPSTREAM_SHA}" HEAD