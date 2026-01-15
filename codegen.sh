#!/bin/bash

# exit on error
set -e

# APIs that should support multiple versions (version-aware generation)
# For APIs in this list, we generate versioned subdirectories and module namespaces
VERSIONED_APIS=("fulfillment-inbound-api-model")

MODELS_REPO_URL="https://github.com/amzn/selling-partner-api-models"
FETCH_MODELS=0

while [[ "$1" == --* ]]; do
  case "$1" in
    --fetch)
      FETCH_MODELS=1
      shift
      ;;
    --repo)
      MODELS_REPO_URL="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

MODELS_DIR=${1:-../selling-partner-api-models/models}
LIB_DIR=${2:-lib}

if [ "$FETCH_MODELS" -eq 1 ]; then
  TEMP_MODELS_DIR=$(mktemp -d)
  trap 'rm -rf "$TEMP_MODELS_DIR"' EXIT
  echo "Cloning selling-partner-api-models into temporary directory..."
  git clone --depth 1 "$MODELS_REPO_URL" "$TEMP_MODELS_DIR" >/dev/null
  MODELS_DIR="$TEMP_MODELS_DIR/models"
fi

# Check if an API should be versioned
is_versioned_api() {
  local api_name="$1"
  for versioned in "${VERSIONED_APIS[@]}"; do
    if [[ "$api_name" == "$versioned" ]]; then
      return 0
    fi
  done
  return 1
}

# Find all JSON specs, sorted to ensure deterministic order
for FILE in $(find "$MODELS_DIR" -name "*.json" | sort); do
  API_NAME=$(basename "$(dirname "$FILE")")
  SPEC_VERSION=$(jq -r '.info.version // "unknown"' "$FILE")

  # Determine if this API should be versioned
  if is_versioned_api "$API_NAME"; then
    # Normalize version for directory (e.g., v0, 2024-03-20)
    VERSION_DIR=$(echo "$SPEC_VERSION" | tr '[:upper:]' '[:lower:]' | sed 's/\./-/g')

    # Normalize version for module suffix (e.g., V0, V2024_03_20)
    VERSION_SUFFIX=$(echo "$SPEC_VERSION" | tr '[:lower:]' '[:upper:]' | sed 's/[.-]/_/g')
    [[ "$VERSION_SUFFIX" =~ ^[0-9] ]] && VERSION_SUFFIX="V$VERSION_SUFFIX"

    # Module name gets the version suffix appended
    BASE_MODULE=$(echo "$API_NAME" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g')
    MODULE_NAME="${BASE_MODULE}::${VERSION_SUFFIX}"

    OUTPUT_DIR="$LIB_DIR/$API_NAME/$VERSION_DIR"
    BOOTSTRAP_NAME="$API_NAME"

    echo "Processing $API_NAME v$SPEC_VERSION (versioned)..."
  else
    # Non-versioned: flat structure as before
    BASE_MODULE=$(echo "$API_NAME" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g')
    MODULE_NAME="$BASE_MODULE"

    OUTPUT_DIR="$LIB_DIR/$API_NAME"
    BOOTSTRAP_NAME="$API_NAME"

    # Clean up old structure for non-versioned APIs
    rm -rf "$OUTPUT_DIR"

    echo "Processing $API_NAME (non-versioned)..."
  fi

  mkdir -p "$OUTPUT_DIR"

  cp config.json "$OUTPUT_DIR/config.json"
  perl -pi -e "s/GEMNAME/${API_NAME}/g" "$OUTPUT_DIR/config.json"
  perl -pi -e "s/MODULENAME/${MODULE_NAME}/g" "$OUTPUT_DIR/config.json"

  swagger-codegen generate -i "$FILE" -l ruby -c "$OUTPUT_DIR/config.json" -o "$OUTPUT_DIR"

  # Flatten generated structure: move lib/GEMNAME.rb and lib/GEMNAME/* up
  if [ -f "$OUTPUT_DIR/lib/${API_NAME}.rb" ]; then
    mv "$OUTPUT_DIR/lib/${API_NAME}.rb" "$OUTPUT_DIR/${API_NAME}.rb"
  fi

  if [ -d "$OUTPUT_DIR/lib/${API_NAME}" ]; then
    mv "$OUTPUT_DIR/lib/${API_NAME}/"* "$OUTPUT_DIR/"
    rm -r "$OUTPUT_DIR/lib"
  fi

  rm -f "$OUTPUT_DIR"/*.gemspec

  # For versioned APIs, update the bootstrapper to require all versions
  if is_versioned_api "$API_NAME"; then
    BOOTSTRAPPER="$LIB_DIR/${API_NAME}.rb"

    # Create or update bootstrapper
    if [ ! -f "$BOOTSTRAPPER" ]; then
      echo "module AmzSpApi::$BASE_MODULE; end" > "$BOOTSTRAPPER"
    fi

    # Add require for this version if not already present
    REQ_LINE="require '${API_NAME}/${VERSION_DIR}/${API_NAME}'"
    if ! grep -q "$(echo "$REQ_LINE" | sed 's/[[\.*^$/]/\\&/g')" "$BOOTSTRAPPER"; then
      echo "$REQ_LINE" >> "$BOOTSTRAPPER"
    fi
  fi
done
