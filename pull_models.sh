#!/bin/bash
set -euo pipefail

MODELS_REF="${MODELS_REF:-main}"
MODELS_REPO="${MODELS_REPO:-https://github.com/amzn/selling-partner-api-models.git}"
DEST=".models"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# init empty repo
git init "$TMP_DIR"
cd "$TMP_DIR"

# add remote
git remote add origin "$MODELS_REPO"

# enable sparse checkout in cone mode
git sparse-checkout init --cone

# only want 'models/' subtree
git sparse-checkout set models

# fetch & checkout desired ref
git fetch --depth 1 origin "$MODELS_REF"
git checkout "$MODELS_REF"

# resolve the SHA we actually got
UPSTREAM_SHA="$(git rev-parse HEAD)"
UPSTREAM_SHORT_SHA="${UPSTREAM_SHA:0:7}"

# snapshot it into repo
DEST_MODELS_DIR="${OLDPWD}/${DEST}/${UPSTREAM_SHORT_SHA}"
rm -rf "$DEST_MODELS_DIR"
mkdir -p "$DEST"
cp -R models "$DEST_MODELS_DIR"

# write provenance
echo "$UPSTREAM_SHA" > "$DEST_MODELS_DIR/UPSTREAM_SHA"

# output for caller
echo "$UPSTREAM_SHORT_SHA"