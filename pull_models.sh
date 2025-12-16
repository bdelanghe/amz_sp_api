#!/bin/bash
set -euo pipefail

MODELS_REF="${MODELS_REF:-main}"
MODELS_REPO="${MODELS_REPO:-https://github.com/amzn/selling-partner-api-models.git}"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

git clone --depth 1 --branch "$MODELS_REF" "$MODELS_REPO" "$TMP_DIR" >/dev/null

UPSTREAM_SHA="$(cd "$TMP_DIR" && git rev-parse HEAD)"
UPSTREAM_SHORT_SHA="${UPSTREAM_SHA:0:7}"

SRC_MODELS_DIR="$TMP_DIR/models"
DEST_MODELS_DIR=".models/${UPSTREAM_SHORT_SHA}"

rm -rf "$DEST_MODELS_DIR"
mkdir -p ".models"
cp -R "$SRC_MODELS_DIR" "$DEST_MODELS_DIR"

echo "$UPSTREAM_SHORT_SHA"