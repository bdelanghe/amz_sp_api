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
  echo "Restoring lib directory from git..."
  git restore --source=ericj/main --worktree -- lib
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

# Verify fulfillment-outbound-api-model has deliveryOfferings and deliveryOffers
echo "✓ Verifying fulfillment-outbound-api-model..."
assert_dir "$LIB_DIR/fulfillment-outbound-api-model"
# Search in models directory for the class definitions
assert_grep "class DeliveryOfferings" "$LIB_DIR/fulfillment-outbound-api-model/models/delivery_offerings.rb" || \
  assert_grep "deliveryOfferings" "$LIB_DIR/fulfillment-outbound-api-model/api/default_api.rb"
assert_grep "class DeliveryOffers" "$LIB_DIR/fulfillment-outbound-api-model/models/delivery_offers.rb" || \
  assert_grep "deliveryOffers" "$LIB_DIR/fulfillment-outbound-api-model/api/default_api.rb"

echo "✓ All validations passed"
echo "✓ test passed"
