# Codegen Verification Test

This directory contains a test suite to verify that `codegen.sh` correctly handles multiple versions of the same API.

## Structure

- `models/`: Contains mock OpenAPI specs for testing.
- `verify_codegen.sh`: The main test script.

## Running the test

From the project root, run:

```bash
./test/verify_codegen.sh
```

The script will:
1. Create a temporary output directory.
2. Run `codegen.sh` using the mock models.
3. Verify that:
   - Separate directories are created for each version (e.g., `v0`, `v1`).
   - The generated Ruby code uses versioned namespaces (e.g., `AmzSpApi::FulfillmentInboundApiModel::V0`).
   - The bootstrapper (e.g., `lib/fulfillment-inbound-api-model.rb`) is updated to require all versions.
