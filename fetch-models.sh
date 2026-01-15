#!/bin/bash
set -euo pipefail

# Usage: ./fetch-models.sh [MODELS_DIR]
# Prints the absolute path to the models directory.

MODELS_REPO_URL="https://github.com/amzn/selling-partner-api-models"
MODELS_SHA="main"
MODELS_DIR=${1:-../selling-partner-api-models/models}
MODELS_REPO_DIR=$(dirname "$MODELS_DIR")

if [[ ! -d "$MODELS_DIR" ]]; then
  echo "Fetching models (pin: $MODELS_SHA) into $MODELS_REPO_DIR..." >&2

  # Try shallow clone for branches/tags
  if git clone --depth 1 --branch "$MODELS_SHA" "$MODELS_REPO_URL" "$MODELS_REPO_DIR" >/dev/null 2>&1; then
    :
  else
    # Fallback for SHAs
    git clone "$MODELS_REPO_URL" "$MODELS_REPO_DIR" >/dev/null
    (cd "$MODELS_REPO_DIR" && git checkout "$MODELS_SHA" >/dev/null 2>&1)
  fi
else
  if [[ -d "$MODELS_REPO_DIR/.git" ]]; then
    echo "Updating models (pin: $MODELS_SHA) in $MODELS_REPO_DIR..." >&2
    (cd "$MODELS_REPO_DIR" && git fetch --quiet && git checkout "$MODELS_SHA" >/dev/null 2>&1 && git pull --quiet)
  fi
fi

echo "$MODELS_DIR"
