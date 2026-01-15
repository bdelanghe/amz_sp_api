#!/bin/sh

# exit on error
set -e

MODELS_DIR=${1:-../selling-partner-api-models/models}
OUTPUT_LIB=${2:-lib}
VERSIONED_MODELS=${VERSIONED_MODELS:-.versioned_models}

# Allow invoking the script with custom model/output roots while keeping the old defaults.
# The VERSIONED_MODELS file is optional; when present it maps relative paths to suffixes.

# Iterate over specs with the original single-pass find/for pattern so the script keeps its linear structure.
for FILE in `find "$MODELS_DIR" -name "*.json"`; do
	# Derive the API name from the swagger folder, matching the original path slicing.
	API_NAME=`basename "$(dirname "$FILE")"`
	RELATIVE_PATH="${FILE#"$MODELS_DIR"/}"

	# If file is in VERSIONED_MODELS, extract version from path:version format.
	VERSION=$(awk -F: -v path="$RELATIVE_PATH" '$1==path {print $2; exit}' "$VERSIONED_MODELS" 2>/dev/null) || true
	if [ -n "$VERSION" ]; then
		# Lowercase the version so gem names stay predictable across platforms.
		VERSION=$(printf '%s' "$VERSION" | tr '[:upper:]' '[:lower:]')
		API_NAME="${API_NAME}-${VERSION}"
	fi

	# Convert the kebab API name into a CamelCase module name for config templating.
	MODULE_NAME=`echo $API_NAME | perl -pe 's/(^|-)./uc($&)/ge;s/-//g'`

	rm -rf "$OUTPUT_LIB/${API_NAME}"
	mkdir -p "$OUTPUT_LIB/$API_NAME"
	cp config.json "$OUTPUT_LIB/$API_NAME"
	# Use sed -i.bak to stay compatible with both GNU and BSD sed, then clean up the backup.
	sed -i.bak "s/GEMNAME/${API_NAME}/g" "$OUTPUT_LIB/${API_NAME}/config.json"
	sed -i.bak "s/MODULENAME/${MODULE_NAME}/g" "$OUTPUT_LIB/${API_NAME}/config.json"
	rm -f "$OUTPUT_LIB/${API_NAME}/config.json.bak"

	# Run swagger-codegen with quoted paths to avoid issues with spaces/special chars.
	swagger-codegen generate -i "$FILE" -l ruby -c "$OUTPUT_LIB/${API_NAME}/config.json" -o "$OUTPUT_LIB/$API_NAME"

	mv "$OUTPUT_LIB/${API_NAME}/lib/${API_NAME}.rb" "$OUTPUT_LIB/"
	# Hoist and flatten the generated lib folder so downstream consumers see the same layout.
	mv "$OUTPUT_LIB/${API_NAME}/lib/${API_NAME}"/* "$OUTPUT_LIB/${API_NAME}"
	# Clean up extra scaffolding the generator creates but we don't need.
	rm -r "$OUTPUT_LIB/${API_NAME}/lib"
	rm "$OUTPUT_LIB/${API_NAME}"/*.gemspec
done
