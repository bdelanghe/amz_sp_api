#!/bin/bash
set -euo pipefail

# Full regeneration pipeline:
# 1) pull upstream models
./pull_models.sh

# 2) run code generation
./codegen.sh

# 3) hoist and normalize shared runtime + provenance
./hoist.sh

# 4) cut/update release artifacts
./release.sh
