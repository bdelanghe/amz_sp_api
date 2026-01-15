#!/bin/bash
set -e

# Codegen Verification Test
#
# This script verifies that codegen.sh correctly handles multiple versions of the same API.
#
# Structure:
# - test/fixtures/models/: Contains mock OpenAPI specs for testing.
# - test/verify_codegen.sh: This test script.
#
# Running the test:
# From the project root, run:
# ./test/verify_codegen.sh
#
# The script will:
# 1. Create a temporary output directory.
# 2. Run codegen.sh using the mock models.
# 3. Verify that:
#    - Separate directories are created for each version (e.g., v0, 2024-03-20).
#    - The generated Ruby code uses versioned namespaces (e.g., AmzSpApi::FulfillmentInboundApiModel::V0).
#    - The bootstrapper is updated correctly to require all versions.

TEST_DIR="test"
MODELS_DIR="$TEST_DIR/fixtures/models"
OUTPUT_LIB="tmp/lib_output"

# Cleanup previous runs
rm -rf "$OUTPUT_LIB"
mkdir -p "$OUTPUT_LIB"

echo "Running codegen.sh..."
./codegen.sh "$MODELS_DIR" "$OUTPUT_LIB"

# Helper to verify API structure and namespacing
verify_api() {
  local api=$1
  local version=$2
  local module=$3
  local base_dir="$OUTPUT_LIB/$api/$version"
  local entry="$base_dir/$api.rb"

  echo "Verifying $api v$version..."

  [ -d "$base_dir" ] || { echo "FAIL: $base_dir missing"; exit 1; }
  [ -f "$entry" ] || { echo "FAIL: $entry missing"; exit 1; }
  [ -f "$base_dir/api_client.rb" ] || { echo "FAIL: $base_dir/api_client.rb missing"; exit 1; }

  local expected_namespace="module AmzSpApi::${module}"
  if ! grep -q "$expected_namespace" "$base_dir/api_client.rb"; then
    echo "FAIL: $base_dir/api_client.rb does not contain $expected_namespace"
    exit 1
  fi
}

# Verify models from test/fixtures/models
# fulfillmentInboundV0.json should become fulfillment-inbound-api-model/v0
verify_api "fulfillment-inbound-api-model" "v0" "FulfillmentInboundApiModel::V0"
# fulfillmentInbound_2024-03-20.json should become fulfillment-inbound-api-model/2024-03-20
verify_api "fulfillment-inbound-api-model" "2024-03-20" "FulfillmentInboundApiModel::V2024_03_20"

# Verify bootstrapper
BOOTSTRAPPER="$OUTPUT_LIB/fulfillment-inbound-api-model.rb"
echo "Verifying bootstrapper $BOOTSTRAPPER..."
[ -f "$BOOTSTRAPPER" ] || { echo "FAIL: $BOOTSTRAPPER missing"; exit 1; }
grep -q "require 'fulfillment-inbound-api-model/v0/fulfillment-inbound-api-model'" "$BOOTSTRAPPER" || { echo "FAIL: v0 require missing in bootstrapper"; exit 1; }
grep -q "require 'fulfillment-inbound-api-model/2024-03-20/fulfillment-inbound-api-model'" "$BOOTSTRAPPER" || { echo "FAIL: 2024-03-20 require missing in bootstrapper"; exit 1; }

echo "VERIFICATION SUCCESSFUL!"
