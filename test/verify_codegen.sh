#!/bin/bash
set -euo pipefail

#!/bin/bash
set -euo pipefail

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

assert_file() { [[ -f "$1" ]] || fail "Missing file: $1"; }
assert_dir()  { [[ -d "$1" ]] || fail "Missing dir:  $1"; }
assert_grep() { local pat=$1 file=$2; grep -q "$pat" "$file" || fail "Expected pattern not found in $file: $pat"; }

TEST_DIR="test"
MODELS_DIR="$TEST_DIR/models"
OUTPUT_LIB="tmp/lib_output"
API="fulfillment-inbound-api-model"
BIN="./codegen.sh"
VERSIONED_MODELS="${VERSIONED_MODELS:-.versioned_models}"

cleanup() { rm -rf "$OUTPUT_LIB"; }
trap cleanup EXIT INT TERM

EXPECTATIONS=$(
  cat <<EOF
v0|${API}-v0|AmzSpApi::FulfillmentInboundApiModelV0
2024-03-20|${API}|AmzSpApi::FulfillmentInboundApiModel
EOF
)

echo "test: setup"
rm -rf "$OUTPUT_LIB"
mkdir -p "$OUTPUT_LIB/$API"
touch "$OUTPUT_LIB/$API/legacy.marker"

echo "test: validate fixtures"
assert_file "$MODELS_DIR/$API/fulfillmentInboundV0.json"
assert_file "$MODELS_DIR/$API/fulfillmentInbound_2024-03-20.json"
[[ ! -f "$MODELS_DIR/$API/v0.json" ]] || fail "Legacy fixture should not exist: $MODELS_DIR/$API/v0.json"
[[ ! -f "$MODELS_DIR/$API/2024-03-20.json" ]] || fail "Legacy fixture should not exist: $MODELS_DIR/$API/2024-03-20.json"
assert_grep "^$API/fulfillmentInboundV0.json:V0$" "$VERSIONED_MODELS"

echo "test: run codegen"
VERSIONED_MODELS="$VERSIONED_MODELS" "$BIN" "$MODELS_DIR" "$OUTPUT_LIB"

[[ ! -f "$OUTPUT_LIB/$API/legacy.marker" ]] || fail "Old artifacts were not cleared"

verify_one() {
  local version=$1 gem_name=$2 module_name=$3
  local api_dir="$OUTPUT_LIB/$gem_name"
  local config="$api_dir/config.json"
  local api_client="$api_dir/api/default_api.rb"

  assert_dir "$api_dir"
  assert_file "$config"
  assert_grep "\"gemName\": \"$gem_name\"" "$config" || fail "gemName not replaced for version=$version"
  assert_grep "\"moduleName\": \"$module_name\"" "$config" || fail "moduleName not replaced for version=$version"
  assert_file "$OUTPUT_LIB/$gem_name.rb" || fail "Entrypoint not hoisted for version=$version"
  assert_file "$api_client" || fail "Missing api client for version=$version"
  assert_grep "$module_name" "$api_client" || fail "Module not declared in api client for version=$version"
  [[ ! -d "$api_dir/lib" ]] || fail "Nested lib directory still present for version=$version"
  if find "$api_dir" -maxdepth 1 -name '*.gemspec' -print -quit | grep -q .; then
    fail "Gemspec not removed for version=$version"
  fi
}

echo "test: verify outputs"
while IFS='|' read -r version gem_name module_name; do
  verify_one "$version" "$gem_name" "$module_name"
done <<< "$EXPECTATIONS"

[[ ! -d "$OUTPUT_LIB/$API/v0" ]] || fail "Nested v0 directory should not exist"
[[ ! -d "$OUTPUT_LIB/$API/2024-03-20" ]] || fail "Nested 2024-03-20 directory should not exist"

echo "test: ok"
