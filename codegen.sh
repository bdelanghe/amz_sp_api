#!/bin/bash
set -euo pipefail

FORCE="${FORCE:-0}"  # set FORCE=1 to allow overwriting an existing tag

MODELS_REF="${MODELS_REF:-main}"
MODELS_REPO="${MODELS_REPO:-https://github.com/amzn/selling-partner-api-models.git}"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

git clone --depth 1 --branch "$MODELS_REF" "$MODELS_REPO" "$TMP_DIR"
MODELS_DIR="$TMP_DIR/models"
# Resolve the exact upstream commit we used
UPSTREAM_SHA="$(cd "$TMP_DIR" && git rev-parse HEAD)"
TAG_NAME="upstream/selling-partner-api-models/${UPSTREAM_SHA:0:7}"

# Bail if tag already exists (unless FORCE=1)
if git rev-parse -q --verify "refs/tags/${TAG_NAME}" >/dev/null; then
  if [[ "$FORCE" != "1" ]]; then
    echo "Tag already exists: ${TAG_NAME}. Re-run with FORCE=1 to overwrite." >&2
    exit 1
  fi
fi

# start clean so deletions propagate
rm -rf lib
mkdir -p lib

for FILE in $(find "$MODELS_DIR" -name "*.json"); do
  FILE_PATH="${FILE#$MODELS_DIR/}"
  API_NAME="${FILE_PATH%%/*}"

  # Amazon Seller Central still uses Fulfillment Inbound API v0.
  # https://developer-docs.amazon.com/sp-api/docs/fulfillment-inbound-api-v0-reference
  if [[ "$API_NAME" == "fulfillment-inbound-api-model" && "$FILE" == *V0.json ]]; then
    API_NAME="${API_NAME}-V0"
  fi

  MODULE_NAME="$(echo "$API_NAME" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g')"

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

# Commit only if something changed
git add lib
git diff --cached --quiet || git commit -m "Generated from selling-partner-api-models@${UPSTREAM_SHA}"

# Tag current HEAD (force only if FORCE=1)
TAG_FORCE_ARG=""
[[ "$FORCE" == "1" ]] && TAG_FORCE_ARG="-f"

git tag $TAG_FORCE_ARG -a "$TAG_NAME" -m "Generated from selling-partner-api-models@${UPSTREAM_SHA}"
echo "Tagged HEAD as ${TAG_NAME} (upstream ${UPSTREAM_SHA})"