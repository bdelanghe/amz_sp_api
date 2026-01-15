#!/bin/bash

# exit on error
set -e

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

# Find all JSON specs, sorted to ensure deterministic overwrite order
for FILE in $(find "$MODELS_DIR" -name "*.json" | sort); do
  # API_NAME is the name of the directory containing the JSON file
  API_NAME=$(basename "$(dirname "$FILE")")
  
  # NOTE: We only support multiple versions for fulfillment-inbound-api-model.
  # V0 gets a suffix, newer versions use the base name.
  if [[ "$API_NAME" == "fulfillment-inbound-api-model" ]]; then
    if [[ "$FILE" == *V0.json || "$FILE" == *v0.json ]]; then
      API_NAME="${API_NAME}-V0"
    fi
  fi

  MODULE_NAME=$(echo "$API_NAME" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g')

  echo "Processing $API_NAME..."

  rm -rf "$LIB_DIR/$API_NAME"
  mkdir -p "$LIB_DIR/$API_NAME"

  cp config.json "$LIB_DIR/$API_NAME/config.json"
  perl -pi -e "s/GEMNAME/${API_NAME}/g" "$LIB_DIR/$API_NAME/config.json"
  perl -pi -e "s/MODULENAME/${MODULE_NAME}/g" "$LIB_DIR/$API_NAME/config.json"

  swagger-codegen generate -i "$FILE" -l ruby -c "$LIB_DIR/$API_NAME/config.json" -o "$LIB_DIR/$API_NAME"

  # Flatten generated structure: move lib/GEMNAME.rb to lib/ and lib/GEMNAME/* to lib/GEMNAME/
  if [ -f "$LIB_DIR/$API_NAME/lib/${API_NAME}.rb" ]; then
    mv "$LIB_DIR/$API_NAME/lib/${API_NAME}.rb" "$LIB_DIR/${API_NAME}.rb"
  fi

  if [ -d "$LIB_DIR/$API_NAME/lib/${API_NAME}" ]; then
    mv "$LIB_DIR/$API_NAME/lib/${API_NAME}/"* "$LIB_DIR/$API_NAME/"
    rm -r "$LIB_DIR/$API_NAME/lib"
  fi
  
  rm -f "$LIB_DIR/$API_NAME"/*.gemspec
done
