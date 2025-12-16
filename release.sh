#!/bin/bash
set -euo pipefail

FORCE="${FORCE:-0}"

# Source provenance (from codegen artifact; no dependency on .models/)
CODEGEN_SHA_FILE="lib/.codegen_models_sha"
if [[ -f "$CODEGEN_SHA_FILE" ]]; then
  UPSTREAM_SHA="$(cat "$CODEGEN_SHA_FILE")"
else
  echo "Missing $CODEGEN_SHA_FILE. Run ./codegen.sh first." >&2
  exit 1
fi

if [[ -z "${UPSTREAM_SHA:-}" ]]; then
  echo "UPSTREAM_SHA is empty in $CODEGEN_SHA_FILE" >&2
  exit 1
fi

UPSTREAM_SHORT_SHA="${UPSTREAM_SHA:0:7}"

MODELS_URL="https://github.com/amzn/selling-partner-api-models/tree/${UPSTREAM_SHA}/models"
MSG="Run codegen.sh against ${MODELS_URL}"

TAG_NAME="amzn/selling-partner-api-models/${UPSTREAM_SHORT_SHA}"

# Refuse to overwrite an existing tag unless FORCE=1
if git rev-parse -q --verify "refs/tags/${TAG_NAME}" >/dev/null; then
  if [[ "$FORCE" != "1" ]]; then
    echo "Tag already exists: ${TAG_NAME}. Re-run with FORCE=1 to overwrite." >&2
    exit 1
  fi
fi

# Commit only if something changed
git add lib
git diff --cached --quiet || git commit -m "$MSG"

# Tag current HEAD (force only if FORCE=1)
TAG_FORCE_FLAG=""
[[ "$FORCE" == "1" ]] && TAG_FORCE_FLAG="-f"
git tag $TAG_FORCE_FLAG -a "$TAG_NAME" -m "$MSG"

REMOTE_NAME="${GIT_REMOTE_NAME:-origin}"
BRANCH="${GIT_BRANCH:-$(git rev-parse --abbrev-ref HEAD)}"

# Push commit and tag
git push "$REMOTE_NAME" "HEAD:$BRANCH"
git push $TAG_FORCE_FLAG "$REMOTE_NAME" "$TAG_NAME"

echo "Released:"
echo "→ Commit: $MSG"
echo "→ Tag:    $TAG_NAME"
echo "→ Branch: $BRANCH"