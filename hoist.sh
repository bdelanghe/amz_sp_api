#!/bin/bash
set -euo pipefail

# Post-generation normalization:
# - hoist shared runtime into top-level lib/
# - patch hoisted files to remove hardcoded namespaces
# - add provenance headers to generated Ruby files
# - write CODEGEN_ARTIFACT_FILE for deterministic skipping

if [[ ! -f "./env.sh" ]]; then
  echo "Missing ./env.sh. Create it (or restore it) to provide MODELS_DIR/UPSTREAM_SHA and prerequisites." >&2
  exit 1
fi
# shellcheck disable=SC1091
source "./env.sh"

: "${UPSTREAM_SHA:?UPSTREAM_SHA must be set by env.sh}"
: "${MODELS_URL:?MODELS_URL must be set by env.sh}"
: "${CODEGEN_ARTIFACT_FILE:?CODEGEN_ARTIFACT_FILE must be set by env.sh}"
: "${RUNTIME_SOURCE_DIR:?RUNTIME_SOURCE_DIR must be set by env.sh}"

if [[ ! -d "lib" ]]; then
  echo "Missing lib/ directory. Run ./codegen.sh first." >&2
  exit 1
fi

#
# Hoist shared runtime files into top-level lib/ from the canonical runtime source module.
if [[ ! -d "$RUNTIME_SOURCE_DIR" ]]; then
  echo "Warning: runtime source dir not found: ${RUNTIME_SOURCE_DIR}" >&2
else
  COMMON_FILES=("api_client.rb" "api_error.rb" "configuration.rb")
  for name in "${COMMON_FILES[@]}"; do
    src="${RUNTIME_SOURCE_DIR}/${name}"
    dest="lib/$name"
    if [[ -f "$src" ]]; then
      {
        echo "# NOTE: Generated and hoisted to lib/ by hoist.sh"
        echo "# Source: ${src}"
        echo
        cat "$src"
      } > "$dest"

      # Normalize module namespace for hoisted files.
      #
      # These files (api_client.rb, api_error.rb, configuration.rb) are hoisted
      # into top-level lib/ so they act as shared runtime infrastructure across
      # all generated SP-API modules.
      #
      # The upstream swagger generator hardcodes an API module namespace
      # (e.g. AmzSpApi::AmazonWarehousingAndDistributionModel) into these files.
      # Once hoisted, that namespace is incorrect and must be removed.
      #
      # Additionally, api_client.rb may reference concrete model namespaces when
      # deserializing return types. We rewrite those lookups to dynamically scan
      # AmzSpApi submodules and resolve the correct model class at runtime.

      # Remove any hardcoded nested API module namespace in hoisted runtime files
      gsed -i -E '/^module AmzSpApi::[A-Za-z0-9_]+$/d' "$dest"

      # Rewrite any hardcoded namespace-based return_type resolver to a dynamic resolver
      gsed -i -E 's/AmzSpApi::[A-Za-z0-9_]+\.const_get\(return_type\)\.build_from_hash\(data\)/AmzSpApi.constants.map{|c| AmzSpApi.const_get(c)}.select{|sub| sub.kind_of?(Module)}.detect{|sub| sub.const_defined?(return_type)}.const_get(return_type).build_from_hash(data)/g' "$dest"

      # Add inline comments at patched sites (inline-only; no new lines).
      gsed -i 's/^\(module AmzSpApi\)\s*$/\1 # NOTE: patched by hoist.sh – hoisted runtime file, removed nested API namespace/' "$dest"
      gsed -i 's/\(AmzSpApi.constants.map{|c| AmzSpApi.const_get(c)}.select{|sub| sub.kind_of?(Module)}.detect{|sub| sub.const_defined?(return_type)}.const_get(return_type).build_from_hash(data)\)/\1 # NOTE: patched by hoist.sh – resolve return_type across AmzSpApi submodules/' "$dest"
    else
      echo "Warning: ${name} not found in ${RUNTIME_SOURCE_DIR}" >&2
    fi
  done
fi

# Add a short provenance note to the top of generated Ruby files.
# This is intentionally lightweight and avoids editing hand-maintained files.
PROVENANCE_HEADER="# NOTE: Generated from ${MODELS_URL}\n# NOTE: If you need to regenerate: ./pull_models.sh && ./codegen.sh\n\n"
while IFS= read -r -d '' rb; do
  # Skip hand-maintained files
  if [[ "$rb" == "lib/amz_sp_api.rb" || "$rb" == "lib/amz_sp_api_version.rb" ]]; then
    continue
  fi

  # Skip only the top-level hoisted runtime files (they already carry a note).
  # Module-scoped runtime files (e.g. lib/<api>/api_client.rb) must still receive provenance headers.
  if [[ "$rb" == "lib/api_client.rb" || "$rb" == "lib/api_error.rb" || "$rb" == "lib/configuration.rb" ]]; then
    continue
  fi

  # Avoid double-prepending if run manually
  if head -n 1 "$rb" | grep -q "^# NOTE: Generated from https://github.com/amzn/selling-partner-api-models/tree/"; then
    continue
  fi

  tmp="${rb}.tmp"
  printf "%b" "$PROVENANCE_HEADER" > "$tmp"
  cat "$rb" >> "$tmp"
  mv "$tmp" "$rb"
done < <(find lib -type f -name "*.rb" -print0)

# Record provenance so we can skip re-running codegen for the same upstream SHA
echo "$UPSTREAM_SHA" > "$CODEGEN_ARTIFACT_FILE"
