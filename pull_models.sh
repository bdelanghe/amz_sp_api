#!/bin/bash
set -euo pipefail

MODELS_REF="${MODELS_REF:-main}"
MODELS_REPO="${MODELS_REPO:-https://github.com/amzn/selling-partner-api-models.git}"

ROOT_DIR="$(pwd)"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# Initialize sparse repo quietly
git init -b "$MODELS_REF" "$TMP_DIR" >/dev/null
cd "$TMP_DIR"

git remote add origin "$MODELS_REPO"

git sparse-checkout init --cone >/dev/null
git sparse-checkout set models >/dev/null

git fetch --depth 1 origin "$MODELS_REF" --quiet
git checkout "$MODELS_REF" --quiet

# Resolve provenance
UPSTREAM_SHA="$(git rev-parse HEAD)"
UPSTREAM_SHORT_SHA="${UPSTREAM_SHA:0:7}"

DEST_DIR="${ROOT_DIR}/.models/${UPSTREAM_SHORT_SHA}"

rm -rf "$DEST_DIR"
mkdir -p "$DEST_DIR/models"

# Snapshot input + provenance in the shape codegen.sh expects:
# .models/<short>/models/<api>/...
cp -R models/* "$DEST_DIR/models/"

echo "$UPSTREAM_SHA" > "$DEST_DIR/UPSTREAM_SHA"

# Write "current" env for codegen.sh to discover
mkdir -p "${ROOT_DIR}/.models"
cat > "${ROOT_DIR}/.models/.env" <<EOF
MODELS_DIR=.models/${UPSTREAM_SHORT_SHA}/models
UPSTREAM_SHA=${UPSTREAM_SHA}
UPSTREAM_SHORT_SHA=${UPSTREAM_SHORT_SHA}
EOF

# Human-readable summary (stderr)
cat >&2 <<EOF
Pulled SP-API models @ ${UPSTREAM_SHORT_SHA} (${MODELS_REF})
→ Snapshot written to .models/${UPSTREAM_SHORT_SHA}
→ Updated .models/.env to export MODELS_DIR and UPSTREAM_SHA
EOF
