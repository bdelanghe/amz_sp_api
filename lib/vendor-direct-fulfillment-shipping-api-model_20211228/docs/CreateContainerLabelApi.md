# AmzSpApi::VendorDirectFulfillmentShippingApiModel20211228::CreateContainerLabelApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_container_label**](CreateContainerLabelApi.md#create_container_label) | **POST** /vendor/directFulfillment/shipping/2021-12-28/containerLabel | 

# **create_container_label**
> CreateContainerLabelResponse create_container_label(body)



Creates container (pallet) label for provided shipment package association

### Example
```ruby
# load the gem
require 'vendor-direct-fulfillment-shipping-api-model_20211228'

api_instance = AmzSpApi::VendorDirectFulfillmentShippingApiModel20211228::CreateContainerLabelApi.new
body = AmzSpApi::VendorDirectFulfillmentShippingApiModel20211228::CreateContainerLabelRequest.new # CreateContainerLabelRequest | Request body containing the container label data.


begin
  result = api_instance.create_container_label(body)
  p result
rescue AmzSpApi::VendorDirectFulfillmentShippingApiModel20211228::ApiError => e
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



