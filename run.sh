#!/bin/bash
set -euo pipefail

FORCE="${FORCE:-0}"

# Guard: the full regeneration pipeline is destructive/expensive; require explicit FORCE=1.
if [[ "$FORCE" != "1" ]]; then
  echo "Refusing to run without FORCE=1." >&2
  echo "Run: FORCE=1 ./run.sh" >&2
  exit 1
fi

# Full regeneration pipeline:
# 1) pull upstream models
# 2) run code generation
# 3) hoist and normalize shared runtime + provenance
# 4) cut/update release artifacts
./pull_models.sh
./codegen.sh
./hoist.sh
./release.sh
