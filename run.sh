#!/bin/bash
set -euo pipefail

# Full regeneration pipeline.
# This script is intentionally dumb: it just runs the phase scripts in order.
# Each phase is responsible for its own inputs/guards/contracts.

# 1) Pull upstream models into .models/ and record provenance (MODELS_DIR + UPSTREAM_SHA).
#    - Ensures we have a pinned upstream commit to generate from.
#    - Produces: .models/.env (and the local models checkout) used by env.sh/codegen.sh.
./pull_models.sh

# 2) Generate Ruby client code into lib/ from the pinned models snapshot.
#    - Destructive: lib/ is rebuilt (hand-maintained files are preserved/restored).
#    - Skips unless FORCE=1 when lib/ already matches the current upstream SHA.
#    - Produces: generated module trees under lib/<api>/ and lib/<api>.rb entry files,
#                plus lib/.codegen_models_sha (the upstream SHA used).
./codegen.sh

# 3) Normalize/patch generated output after codegen.
#    - Hoists shared runtime files (api_client.rb, api_error.rb, configuration.rb) to top-level lib/.
#    - Removes hardcoded module namespaces in hoisted runtime and adds inline patch notes.
#    - Prepends provenance headers to generated Ruby files (excluding hand-maintained + hoisted runtime files).
#    - Produces: stable, repo-friendly lib/ layout that can be required consistently.
./hoist.sh

# 4) Commit and tag the generated artifacts for distribution and traceability.
#    - Commits lib/ only if there are changes.
#    - Creates/updates an annotated tag: amzn/selling-partner-api-models/<short_sha>.
#    - Pushes branch + tag to the configured remote.
./release.sh
