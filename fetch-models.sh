#!/bin/bash
set -euo pipefail

# Usage: ./fetch-models.sh [MODELS_DIR]
# Prints the absolute (or caller-normalized) path to the models directory.
# Logs go to stderr so downstream scripts can capture just the directory path.

# Repo URL and deterministic pin for reproducibility.
MODELS_REPO_URL="https://github.com/amzn/selling-partner-api-models"
MODELS_SHA="main"
# Allow overriding the destination without editing the script.
MODELS_DIR=${1:-../selling-partner-api-models/models}
# Clone/pull happens in the parent directory of MODELS_DIR.
MODELS_REPO_DIR=$(dirname "$MODELS_DIR")

if [[ ! -d "$MODELS_DIR" ]]; then
  echo "Fetching models (pin: $MODELS_SHA) into $MODELS_REPO_DIR..." >&2

  # Keep the flow simple: clone the repo once and checkout the pin.
  git clone "$MODELS_REPO_URL" "$MODELS_REPO_DIR" >/dev/null
  (cd "$MODELS_REPO_DIR" && git checkout "$MODELS_SHA" >/dev/null 2>&1)
else
  if [[ -d "$MODELS_REPO_DIR/.git" ]]; then
    (cd "$MODELS_REPO_DIR" && git fetch --quiet && git checkout "$MODELS_SHA" >/dev/null 2>&1 && git pull --quiet)
  fi
fi

MODELS_SHA_ACTUAL=$(cd "$MODELS_REPO_DIR" && git rev-parse --short HEAD)
MODELS_SHA_FULL=$(cd "$MODELS_REPO_DIR" && git rev-parse HEAD)
echo "✓ models ready $MODELS_DIR @${MODELS_SHA_ACTUAL} https://github.com/amzn/selling-partner-api-models/commit/${MODELS_SHA_FULL}"
