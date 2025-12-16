#!/bin/bash
set -euo pipefail

FORCE="${FORCE:-0}"

# Source provenance
if [[ -f ".models/.env" ]]; then
  # shellcheck disable=SC1091
  source ".models/.env"
else
  echo "Missing .models/.env. Run ./pull_models.sh first." >&2
  exit 1
fi

: "${UPSTREAM_SHA:?UPSTREAM_SHA missing in .models/.env}"
: "${UPSTREAM_SHORT_SHA:?UPSTREAM_SHORT_SHA missing in .models/.env}"

TAG_NAME="amzn/selling-partner-api-models/${UPSTREAM_SHORT_SHA}"
MSG="Results of running codegen.sh against https://github.com/amzn/selling-partner-api-models/tree/${UPSTREAM_SHA}/models"

REMOTE_NAME="${GIT_REMOTE_NAME:-origin}"
BRANCH="${GIT_BRANCH:-$(git rev-parse --abbrev-ref HEAD)}"

# Push commit and tag
git push "$REMOTE_NAME" "HEAD:$BRANCH"
git push $TAG_FORCE_ARG "$REMOTE_NAME" "$TAG_NAME"

echo "Released:"
echo "→ Commit: $MSG"
echo "→ Tag:    $TAG_NAME"
echo "→ Branch: $BRANCH"