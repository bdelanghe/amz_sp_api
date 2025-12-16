#!/bin/bash
set -euo pipefail

FORCE="${FORCE:-0}"
MODELS_DIR="${MODELS_DIR:-}"
UPSTREAM_SHA="${UPSTREAM_SHA:-}"

# Self-discovery:
# 1) explicit env vars
# 2) newest snapshot in .models/
# 3) fail loudly
if [[ -z "$MODELS_DIR" || -z "$UPSTREAM_SHA" ]]; then
  latest_snapshot="$(ls -1dt .models/* 2>/dev/null | head -n 1 || true)"

  if [[ -n "$latest_snapshot" \
        && -d "$latest_snapshot/models" \
        && -f "$latest_snapshot/UPSTREAM_SHA" ]]; then
    MODELS_DIR="$latest_snapshot/models"
    UPSTREAM_SHA="$(cat "$latest_snapshot/UPSTREAM_SHA")"
  else
    echo "No models found." >&2
    echo "Run ./pull_models.sh or set MODELS_DIR and UPSTREAM_SHA." >&2
    exit 1
  fi
fi

# Hard fail before find/loop
if [[ ! -d "$MODELS_DIR" ]]; then
  echo "MODELS_DIR is not a directory: '$MODELS_DIR'" >&2
  exit 1
fi

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

# Use find safely; if find fails, script exits; handles spaces
while IFS= read -r -d '' FILE; do
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
done < <(find "$MODELS_DIR" -name "*.json" -print0)

# Commit only if something changed
git add lib
git diff --cached --quiet || git commit -m "Generated from selling-partner-api-models@${UPSTREAM_SHA}"

# Tag current HEAD (force only if FORCE=1)
TAG_FORCE_ARG=""
[[ "$FORCE" == "1" ]] && TAG_FORCE_ARG="-f"

git tag $TAG_FORCE_ARG -a "$TAG_NAME" -m "Generated from selling-partner-api-models@${UPSTREAM_SHA}"
echo "Tagged HEAD as ${TAG_NAME} (upstream ${UPSTREAM_SHA})"