#!/bin/bash
set -e

# This script verifies that codegen.sh supports multiple versions of the same API.

TEST_DIR="test"
MODELS_DIR="$TEST_DIR/models"
OUTPUT_LIB="$TEST_DIR/lib_output"

# Cleanup previous runs
rm -rf "$OUTPUT_LIB"
mkdir -p "$OUTPUT_LIB"

echo "Running codegen.sh..."
./codegen.sh "$MODELS_DIR" "$OUTPUT_LIB"

# Helper to verify API structure and namespacing
verify_api() {
  local api=$1
  local module=$2
  local dir="$OUTPUT_LIB/$api"
  local entry="$OUTPUT_LIB/$api.rb"

  echo "Verifying $api..."

  [ -d "$dir" ] || { echo "FAIL: $dir missing"; exit 1; }
  [ -f "$entry" ] || { echo "FAIL: $entry missing"; exit 1; }
  [ -f "$dir/api_client.rb" ] || { echo "FAIL: $dir/api_client.rb missing"; exit 1; }

  local expected_namespace="AmzSpApi::${module}"
  if ! grep -q "$expected_namespace" "$dir/api_client.rb"; then
    echo "FAIL: $dir/api_client.rb does not contain $expected_namespace"
    exit 1
  fi
}

# Verify models from test/models
# fulfillmentInboundV0.json should become fulfillment-inbound-api-model-V0
verify_api "fulfillment-inbound-api-model-V0" "FulfillmentInboundApiModelV0"
# fulfillmentInbound_2024-03-20.json should become fulfillment-inbound-api-model
verify_api "fulfillment-inbound-api-model" "FulfillmentInboundApiModel"

echo "VERIFICATION SUCCESSFUL!"
