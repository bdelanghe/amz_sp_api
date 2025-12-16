#!/bin/bash
set -euo pipefail

MODELS_REF="${MODELS_REF:-main}"
MODELS_REPO="${MODELS_REPO:-https://github.com/amzn/selling-partner-api-models.git}"
DEST=".models"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# init a new repo with an explicit initial branch matching the ref
git init -b "$MODELS_REF" "$TMP_DIR"
cd "$TMP_DIR"

git remote add origin "$MODELS_REPO"

# enable sparse checkout
git sparse-checkout init --cone

# only want 'models/' directory
git sparse-checkout set models

# fetch and checkout just the ref we care about
git fetch --depth 1 origin "$MODELS_REF"
git checkout "$MODELS_REF"

# resolve the exact commit SHA
UPSTREAM_SHA="$(git rev-parse HEAD)"
UPSTREAM_SHORT_SHA="${UPSTREAM_SHA:0:7}"

# snapshot it into your repo
DEST_MODELS_DIR="${OLDPWD}/${DEST}/${UPSTREAM_SHORT_SHA}"
rm -rf "$DEST_MODELS_DIR"
mkdir -p "$DEST"
cp -R models "$DEST_MODELS_DIR"

# provenance
echo "$UPSTREAM_SHA" > "$DEST_MODELS_DIR/UPSTREAM_SHA"

echo "$UPSTREAM_SHORT_SHA"