#!/bin/bash
set -euo pipefail

# Full regeneration pipeline:
# 1) pull upstream models
# 2) run code generation
# 3) hoist and normalize shared runtime + provenance
# 4) cut/update release artifacts

./pull_models.sh
./codegen.sh
./hoist.sh
./release.sh
