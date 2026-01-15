#!/bin/bash
set -euo pipefail

# Usage: ./scripts/fetch-models.sh [--repo URL] [--pin SHA/BRANCH/TAG]
# Prints the absolute path to the models directory.

MODELS_REPO_URL="https://github.com/amzn/selling-partner-api-models"
MODELS_SHA="main"

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --repo) MODELS_REPO_URL="$2"; shift 2 ;;
    --pin) MODELS_SHA="$2"; shift 2 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

TEMP_DIR=$(mktemp -d)

echo "Fetching models (pin: $MODELS_SHA) into $TEMP_DIR..." >&2

# Try shallow clone for branches/tags
if git clone --depth 1 --branch "$MODELS_SHA" "$MODELS_REPO_URL" "$TEMP_DIR" >/dev/null 2>&1; then
  :
else
  # Fallback for SHAs
  git clone "$MODELS_REPO_URL" "$TEMP_DIR" >/dev/null
  (cd "$TEMP_DIR" && git checkout "$MODELS_SHA" >/dev/null 2>&1)
fi

echo "$TEMP_DIR/models"
