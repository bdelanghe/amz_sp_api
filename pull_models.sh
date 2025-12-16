#!/bin/bash
set -euo pipefail

MODELS_REF="${MODELS_REF:-main}"
MODELS_REPO="${MODELS_REPO:-https://github.com/amzn/selling-partner-api-models.git}"

# Resolve the commit SHA for the ref without cloning
UPSTREAM_SHA="$(git ls-remote "$MODELS_REPO" "refs/heads/$MODELS_REF" "refs/tags/$MODELS_REF" \
  | awk 'NR==1 {print $1}')"

if [[ -z "${UPSTREAM_SHA:-}" ]]; then
  echo "Could not resolve MODELS_REF=$MODELS_REF on $MODELS_REPO" >&2
  exit 1
fi

UPSTREAM_SHORT_SHA="${UPSTREAM_SHA:0:7}"
DEST_MODELS_DIR=".models/${UPSTREAM_SHORT_SHA}"

rm -rf "$DEST_MODELS_DIR"
mkdir -p "$DEST_MODELS_DIR"

# Export only the models/ subtree into .models/<short_sha>/
git archive --remote="$MODELS_REPO" "$UPSTREAM_SHA" models \
  | tar -x -C "$DEST_MODELS_DIR"

# Provenance for codegen/tag/commit messages
echo "$UPSTREAM_SHA" > "$DEST_MODELS_DIR/UPSTREAM_SHA"

echo "$UPSTREAM_SHORT_SHA"