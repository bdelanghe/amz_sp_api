# Load models env (produced by pull_models.sh)
if [[ -f ".models/.env" ]]; then
  # shellcheck disable=SC1091
  source ".models/.env"
else
  echo "Missing .models/.env (run ./pull_models.sh first)" >&2
  exit 1
fi

# Required inputs
: "${MODELS_DIR:?}"
: "${UPSTREAM_SHA:?}"

# Upstream reference (informational)
MODELS_URL="https://github.com/amzn/selling-partner-api-models/tree/${UPSTREAM_SHA}/models"

# Codegen artifacts
CODEGEN_ARTIFACT_FILE="lib/.codegen_models_sha"
RUNTIME_SOURCE_DIR="lib/fulfillment-outbound-api-model"
CODEGEN_LOG_DIR=".codegen-logs"

# Execution flags
FORCE="${FORCE:-0}"
[[ "$FORCE" == "1" ]] || FORCE="0"
