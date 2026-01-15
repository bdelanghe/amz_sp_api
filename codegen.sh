#!/bin/bash

# exit on error
set -e

MODELS_DIR=${1:-../selling-partner-api-models/models}
OUTPUT_LIB=${2:-lib}
VERSIONED_MODELS=${VERSIONED_MODELS:-.versioned_models}

for FILE in `find "$MODELS_DIR" -name "*.json"`; do
	API_NAME=`basename "$(dirname "$FILE")"`
	RELATIVE_PATH="${FILE#"$MODELS_DIR"/}"

	# If file is in VERSIONED_MODELS, extract version from path:version format.
	VERSION=$(grep "^$RELATIVE_PATH:" "$VERSIONED_MODELS" 2>/dev/null | cut -d: -f2) && \
	  API_NAME="${API_NAME}-${VERSION}" || true

	MODULE_NAME=`echo $API_NAME | perl -pe 's/(^|-)./uc($&)/ge;s/-//g'`

	rm -rf "$OUTPUT_LIB/${API_NAME}"
	mkdir -p "$OUTPUT_LIB/$API_NAME"
	cp config.json "$OUTPUT_LIB/$API_NAME"
	sed -i '' "s/GEMNAME/${API_NAME}/g" "$OUTPUT_LIB/${API_NAME}/config.json"
	sed -i '' "s/MODULENAME/${MODULE_NAME}/g" "$OUTPUT_LIB/${API_NAME}/config.json"

	swagger-codegen generate -i "$FILE" -l ruby -c "$OUTPUT_LIB/${API_NAME}/config.json" -o "$OUTPUT_LIB/$API_NAME"

	mv "$OUTPUT_LIB/${API_NAME}/lib/${API_NAME}.rb" "$OUTPUT_LIB/"
	mv "$OUTPUT_LIB/${API_NAME}/lib/${API_NAME}"/* "$OUTPUT_LIB/${API_NAME}"
	rm -r "$OUTPUT_LIB/${API_NAME}/lib"
	rm "$OUTPUT_LIB/${API_NAME}"/*.gemspec
done
