# AmzSpApi::VendorDirectFulfillmentShippingApiModelVendorDirectFulfillmentShipping_20211228::CreateContainerLabelApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_container_label**](CreateContainerLabelApi.md#create_container_label) | **POST** /vendor/directFulfillment/shipping/2021-12-28/containerLabel | createContainerLabel

# **create_container_label**
> CreateContainerLabelResponse create_container_label(body)

createContainerLabel

Creates a container (pallet) label for the associated shipment package.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 10 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'vendor-direct-fulfillment-shipping-api-model-vendorDirectFulfillmentShipping_2021-12-28'

api_instance = AmzSpApi::VendorDirectFulfillmentShippingApiModelVendorDirectFulfillmentShipping_20211228::CreateContainerLabelApi.new
body = AmzSpApi::VendorDirectFulfillmentShippingApiModelVendorDirectFulfillmentShipping_20211228::CreateContainerLabelRequest.new # CreateContainerLabelRequest | Request body containing the container label data.


begin
  #createContainerLabel
  result = api_instance.create_container_label(body)
  p result
rescue AmzSpApi::VendorDirectFulfillmentShippingApiModelVendorDirectFulfillmentShipping_20211228::ApiError => e
  puts "Exception when calling CreateContainerLabelApi->create_container_label: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CreateContainerLabelRequest**](CreateContainerLabelRequest.md)| Request body containing the container label data. | 

### Return type

[**CreateContainerLabelResponse**](CreateContainerLabelResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, containerLabel



