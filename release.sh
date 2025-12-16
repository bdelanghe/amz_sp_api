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
MSG="Run codegen.sh against amzn/selling-partner-api-models@${UPSTREAM_SHA}"

# Refuse to overwrite an existing tag unless FORCE=1
if git rev-parse -q --verify "refs/tags/${TAG_NAME}" >/dev/null; then
  [[ "$FORCE" == "1" ]] || {
    echo "Tag already exists: ${TAG_NAME}. Re-run with FORCE=1 to overwrite." >&2
    exit 1
  }
fi

# Commit only if something changed
git add lib
git diff --cached --quiet || git commit -m "$MSG"

# Tag current HEAD
TAG_FORCE_ARG=""
[[ "$FORCE" == "1" ]] && TAG_FORCE_ARG="-f"
git tag $TAG_FORCE_ARG -a "$TAG_NAME" -m "$MSG"

REMOTE_NAME="${GIT_REMOTE_NAME:-origin}"
BRANCH="${GIT_BRANCH:-$(git rev-parse --abbrev-ref HEAD)}"

# Push commit and tag
git push "$REMOTE_NAME" "HEAD:$BRANCH"
git push $TAG_FORCE_ARG "$REMOTE_NAME" "$TAG_NAME"

echo "Released:"
echo "→ Commit: $MSG"
echo "→ Tag:    $TAG_NAME"
echo "→ Branch: $BRANCH"