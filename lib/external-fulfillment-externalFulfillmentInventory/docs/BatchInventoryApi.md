# AmzSpApi::ExternalFulfillmentInventory::BatchInventoryApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**batch_inventory**](BatchInventoryApi.md#batch_inventory) | **POST** /externalFulfillment/inventory/2024-09-11/inventories | 

# **batch_inventory**
> BatchInventoryResponse batch_inventory(body)



Make up to 10 inventory requests. The response includes the set of responses that correspond to requests. The response for each successful request in the set includes the  inventory count for the provided `sku` and `locationId` pair.

### Example
```ruby
# load the gem
require 'external-fulfillment-externalFulfillmentInventory'

api_instance = AmzSpApi::ExternalFulfillmentInventory::BatchInventoryApi.new
body = AmzSpApi::ExternalFulfillmentInventory::BatchInventoryRequest.new # BatchInventoryRequest | A list of inventory requests.


begin
  result = api_instance.batch_inventory(body)
  p result
rescue AmzSpApi::ExternalFulfillmentInventory::ApiError => e
  puts "Exception when calling BatchInventoryApi->batch_inventory: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**BatchInventoryRequest**](BatchInventoryRequest.md)| A list of inventory requests. | 

### Return type

[**BatchInventoryResponse**](BatchInventoryResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



