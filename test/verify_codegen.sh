#!/bin/bash
set -euo pipefail

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

TEST_DIR="test"
MODELS_DIR="$TEST_DIR/models"
OUTPUT_LIB="tmp/lib_output"
API="fulfillment-inbound-api-model"
BIN="./codegen.sh"
VERSIONS=("v0" "2024-03-20")

expected_gem_name_for_version() {
  local version=$1
  case "$version" in
    v0) echo "${API}-v0" ;;
    2024-03-20) echo "${API}" ;;
    *) fail "Unknown expected gem name for version $version" ;;
  esac
}

expected_module_name_for_version() {
  local version=$1
  case "$version" in
    v0) echo "AmzSpApi::FulfillmentInboundApiModelV0" ;;
    2024-03-20) echo "AmzSpApi::FulfillmentInboundApiModel" ;;
    *) fail "Unknown expected module name for version $version" ;;
  esac
}

cleanup() {
  rm -rf "$OUTPUT_LIB"
}

trap cleanup EXIT INT TERM

echo "Preparing output directory..."
rm -rf "$OUTPUT_LIB"
mkdir -p "$OUTPUT_LIB/$API"
touch "$OUTPUT_LIB/$API/legacy.marker"

echo "Running codegen.sh..."
"$BIN" "$MODELS_DIR" "$OUTPUT_LIB"

echo "Step 1: previous artifacts removed..."
[ ! -f "$OUTPUT_LIB/$API/legacy.marker" ] || fail "Old artifacts were not cleared before generation"

verify_version_output() {
  local version=$1
  local gem_name
  gem_name=$(expected_gem_name_for_version "$version")
  local api_dir="$OUTPUT_LIB/$gem_name"
  local config="$api_dir/config.json"
  local module_name
  module_name=$(expected_module_name_for_version "$version")

  echo "Verifying $gem_name ($version)..."
  [ -d "$api_dir" ] || fail "$api_dir missing"
  [ -f "$config" ] || fail "$config missing"
  grep -q "\"gemName\": \"$gem_name\"" "$config" || fail "gemName placeholder not replaced for $version"
  grep -q "\"moduleName\": \"$module_name\"" "$config" || fail "moduleName placeholder not replaced for $version"

  [ -f "$OUTPUT_LIB/$gem_name.rb" ] || fail "$OUTPUT_LIB/$gem_name.rb missing"
  
  local api_client="$api_dir/api/default_api.rb"
  [ -f "$api_client" ] || fail "$api_client missing"
  grep -q "$module_name" "$api_client" || fail "$api_client does not declare $module_name"

  [ ! -d "$api_dir/lib" ] || fail "Nested lib directory still present for $version"
  if find "$api_dir" -maxdepth 1 -name '*.gemspec' -print -quit | grep -q .; then
    fail "Gemspec not removed for $version"
  fi
}

for version in "${VERSIONS[@]}"; do
  verify_version_output "$version"
done

echo "Step 2: verify no nested versions..."
[ ! -d "$OUTPUT_LIB/$API/v0" ] || fail "Nested v0 directory should not exist"
[ ! -d "$OUTPUT_LIB/$API/2024-03-20" ] || fail "Nested 2024-03-20 directory should not exist"

echo "VERIFICATION SUCCESSFUL!"
