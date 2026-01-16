#!/bin/bash
set -euo pipefail

# Reset lib directory to exactly match ericj/main
# This provides a guaranteed 1:1 match by:
# 1. Using git checkout to restore the exact tree from ericj/main
# 2. Cleaning untracked files (including ignored files with -x)
# 3. Verifying with git diff that no differences remain

echo "Resetting lib directory to ericj/main..."
git checkout ericj/main -- lib
git clean -fdx -- lib

# Verify the reset worked
if ! git diff --quiet --name-status ericj/main -- lib; then
  echo "Warning: lib/ does not exactly match ericj/main after reset" >&2
  git diff --name-status ericj/main -- lib
  exit 1
fi

echo "✓ lib directory successfully reset to ericj/main"
