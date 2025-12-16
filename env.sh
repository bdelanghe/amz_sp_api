#!/bin/bash
set -euo pipefail

# Repo root anchor: allow scripts to be run from any working directory.
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"
export ROOT_DIR

require_cmd() {
  local cmd="$1"
  local hint="${2:-}"
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "Missing required command: ${cmd}" >&2
    if [[ -n "$hint" ]]; then
      echo "$hint" >&2
    fi
    exit 1
  }
}

require_file() {
  local path="$1"
  local hint="${2:-}"
  [[ -f "$path" ]] || {
    echo "Missing required file: ${path}" >&2
    if [[ -n "$hint" ]]; then
      echo "$hint" >&2
    fi
    exit 1
  }
}

# Tool prerequisites used by the pipeline scripts.
require_cmd git
require_cmd find
require_cmd mktemp
require_cmd perl
require_cmd gsed "Install with: brew install gnu-sed"
require_cmd swagger-codegen "Install swagger-codegen (3.x) and ensure it is on PATH"

# Contract inputs: models checkout metadata (produced by ./pull_models.sh)
MODELS_ENV_FILE=".models/.env"
export MODELS_ENV_FILE

if [[ -f "$MODELS_ENV_FILE" ]]; then
  # shellcheck disable=SC1091
  source "$MODELS_ENV_FILE"
else
  echo "Missing ${MODELS_ENV_FILE}." >&2
  echo "Run ./pull_models.sh first." >&2
  exit 1
fi

: "${MODELS_DIR:?MODELS_DIR must be set}"
: "${UPSTREAM_SHA:?UPSTREAM_SHA must be set}"

require_file "config.json" "Expected in repo root; required for swagger-codegen config template"

# Contract outputs derived from UPSTREAM_SHA / repo structure
MODELS_URL="https://github.com/amzn/selling-partner-api-models/tree/${UPSTREAM_SHA}/models"
export MODELS_URL

CODEGEN_ARTIFACT_FILE="lib/.codegen_models_sha"
export CODEGEN_ARTIFACT_FILE

# Canonical runtime source module for hoisted shared runtime files
RUNTIME_SOURCE_DIR="lib/fulfillment-outbound-api-model"
export RUNTIME_SOURCE_DIR

if [[ ! -d "$MODELS_DIR" ]]; then
  echo "MODELS_DIR is not a directory: '$MODELS_DIR'" >&2
  exit 1
fi

# Contract outputs expected by scripts sourcing env.sh
export MODELS_DIR
export UPSTREAM_SHA
FORCE="${FORCE:-0}"
export FORCE