#!/bin/bash
set -euo pipefail

# Test that codegen.sh runs successfully and produces expected output,
# then restores the lib directory from git regardless of test result

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

assert_dir()  { [[ -d "$1" ]] || fail "Missing dir:  $1"; }
assert_file() { [[ -f "$1" ]] || fail "Missing file: $1"; }
assert_grep() { local pat=$1 file=$2; grep -q "$pat" "$file" || fail "Expected pattern not found in $file: $pat"; }
assert_no_file() { [[ ! -f "$1" ]] || fail "File should not exist: $1"; }
assert_no_dir() { [[ ! -d "$1" ]] || fail "Directory should not exist: $1"; }

# Always restore lib from git, regardless of test result
cleanup() {
  bash "$(dirname "$0")/reset_lib.sh"
}
trap cleanup EXIT INT TERM

BIN="./codegen.sh"
MODELS_DIR="../selling-partner-api-models/models"
LIB_DIR="lib"

echo "✓ Running codegen.sh..."
if ! "$BIN"; then
  fail "codegen.sh exited with error"
fi
echo "✓ codegen.sh executed successfully"

# Verify fulfillment-inbound-api-model-V0 exists and contains correct module
echo "✓ Verifying fulfillment-inbound-api-model-V0..."
assert_dir "$LIB_DIR/fulfillment-inbound-api-model-v0"
assert_file "$LIB_DIR/fulfillment-inbound-api-model-v0.rb"
assert_grep "AmzSpApi::FulfillmentInboundApiModelV0" "$LIB_DIR/fulfillment-inbound-api-model-v0.rb"

# Verify fulfillment-inbound-api-model exists (2024-03-20 version)
echo "✓ Verifying fulfillment-inbound-api-model..."
assert_dir "$LIB_DIR/fulfillment-inbound-api-model"
assert_file "$LIB_DIR/fulfillment-inbound-api-model.rb"
assert_grep "AmzSpApi::FulfillmentInboundApiModel" "$LIB_DIR/fulfillment-inbound-api-model.rb"

# Verify the 2024-03-20 versioned variant does NOT exist
echo "✓ Verifying fulfillment-inbound-api-model-2024-03-20 does not exist..."
assert_no_dir "$LIB_DIR/fulfillment-inbound-api-model-2024-03-20"
assert_no_file "$LIB_DIR/fulfillment-inbound-api-model-2024-03-20.rb"

# Verify fulfillment-outbound-api-model has deliveryOfferings and deliveryOffers models
echo "✓ Verifying fulfillment-outbound-api-model..."
assert_dir "$LIB_DIR/fulfillment-outbound-api-model"
# Check that the GetDeliveryOffers models are present (from the swagger endpoints)
assert_file "$LIB_DIR/fulfillment-outbound-api-model/models/delivery_offer.rb"
assert_file "$LIB_DIR/fulfillment-outbound-api-model/models/get_delivery_offers_request.rb"
assert_file "$LIB_DIR/fulfillment-outbound-api-model/models/get_delivery_offers_response.rb"

echo "✓ All validations passed"
echo "✓ test passed"
