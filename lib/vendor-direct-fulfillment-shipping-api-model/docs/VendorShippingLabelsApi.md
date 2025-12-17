# AmzSpApi::VendorDirectFulfillmentShippingApiModel::VendorShippingLabelsApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_shipping_labels**](VendorShippingLabelsApi.md#create_shipping_labels) | **POST** /vendor/directFulfillment/shipping/2021-12-28/shippingLabels/{purchaseOrderNumber} | createShippingLabels
[**get_shipping_label**](VendorShippingLabelsApi.md#get_shipping_label) | **GET** /vendor/directFulfillment/shipping/2021-12-28/shippingLabels/{purchaseOrderNumber} | getShippingLabel
[**get_shipping_labels**](VendorShippingLabelsApi.md#get_shipping_labels) | **GET** /vendor/directFulfillment/shipping/2021-12-28/shippingLabels | getShippingLabels
[**submit_shipping_label_request**](VendorShippingLabelsApi.md#submit_shipping_label_request) | **POST** /vendor/directFulfillment/shipping/2021-12-28/shippingLabels | submitShippingLabelRequest

# **create_shipping_labels**
> ShippingLabel create_shipping_labels(bodypurchase_order_number)

createShippingLabels

Creates shipping labels for a purchase order and returns the labels.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 10 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values then those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'vendor-direct-fulfillment-shipping-api-model'

api_instance = AmzSpApi::VendorDirectFulfillmentShippingApiModel::VendorShippingLabelsApi.new
body = AmzSpApi::VendorDirectFulfillmentShippingApiModel::CreateShippingLabelsRequest.new # CreateShippingLabelsRequest | The request payload that contains the parameters for creating shipping labels.
purchase_order_number = 'purchase_order_number_example' # String | The purchase order number for which you want to return the shipping labels. It should be the same number as the `purchaseOrderNumber` in the order.


begin
  #createShippingLabels
  result = api_instance.create_shipping_labels(bodypurchase_order_number)
  p result
rescue AmzSpApi::VendorDirectFulfillmentShippingApiModel::ApiError => e
  puts "Exception when calling VendorShippingLabelsApi->create_shipping_labels: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CreateShippingLabelsRequest**](CreateShippingLabelsRequest.md)| The request payload that contains the parameters for creating shipping labels. | 
 **purchase_order_number** | **String**| The purchase order number for which you want to return the shipping labels. It should be the same number as the &#x60;purchaseOrderNumber&#x60; in the order. | 

### Return type

[**ShippingLabel**](ShippingLabel.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_shipping_label**
> ShippingLabel get_shipping_label(purchase_order_number)

getShippingLabel

Returns a shipping label for the `purchaseOrderNumber` that you specify.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 10 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values then those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'vendor-direct-fulfillment-shipping-api-model'

api_instance = AmzSpApi::VendorDirectFulfillmentShippingApiModel::VendorShippingLabelsApi.new
purchase_order_number = 'purchase_order_number_example' # String | The purchase order number for which you want to return the shipping label. It should be the same `purchaseOrderNumber` that you received in the order.


begin
  #getShippingLabel
  result = api_instance.get_shipping_label(purchase_order_number)
  p result
rescue AmzSpApi::VendorDirectFulfillmentShippingApiModel::ApiError => e
  puts "Exception when calling VendorShippingLabelsApi->get_shipping_label: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **purchase_order_number** | **String**| The purchase order number for which you want to return the shipping label. It should be the same &#x60;purchaseOrderNumber&#x60; that you received in the order. | 

### Return type

[**ShippingLabel**](ShippingLabel.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_shipping_labels**
> ShippingLabelList get_shipping_labels(created_after, created_before, opts)

getShippingLabels

Returns a list of shipping labels created during the time frame that you specify. Use the `createdAfter` and `createdBefore` parameters to define the time frame. You must use both of these parameters. The date range to search must not be more than seven days.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 10 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values then those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'vendor-direct-fulfillment-shipping-api-model'

api_instance = AmzSpApi::VendorDirectFulfillmentShippingApiModel::VendorShippingLabelsApi.new
created_after = DateTime.parse('2013-10-20T19:20:30+01:00') # DateTime | Shipping labels that became available after this date and time will be included in the result. Values are in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.
created_before = DateTime.parse('2013-10-20T19:20:30+01:00') # DateTime | Shipping labels that became available before this date and time will be included in the result. Values are in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.
opts = { 
  ship_from_party_id: 'ship_from_party_id_example', # String | The vendor `warehouseId` for order fulfillment. If not specified, the result contains orders for all warehouses.
  limit: 56, # Integer | The limit to the number of records returned.
  sort_order: 'ASC', # String | The sort order creation date. You can choose between ascending (`ASC`) or descending (`DESC`) sort order.
  next_token: 'next_token_example' # String | Used for pagination when there are more ship labels than the specified result size limit. The token value is returned in the previous API call.
}

begin
  #getShippingLabels
  result = api_instance.get_shipping_labels(created_after, created_before, opts)
  p result
rescue AmzSpApi::VendorDirectFulfillmentShippingApiModel::ApiError => e
  puts "Exception when calling VendorShippingLabelsApi->get_shipping_labels: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **created_after** | **DateTime**| Shipping labels that became available after this date and time will be included in the result. Values are in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. | 
 **created_before** | **DateTime**| Shipping labels that became available before this date and time will be included in the result. Values are in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. | 
 **ship_from_party_id** | **String**| The vendor &#x60;warehouseId&#x60; for order fulfillment. If not specified, the result contains orders for all warehouses. | [optional] 
 **limit** | **Integer**| The limit to the number of records returned. | [optional] 
 **sort_order** | **String**| The sort order creation date. You can choose between ascending (&#x60;ASC&#x60;) or descending (&#x60;DESC&#x60;) sort order. | [optional] [default to ASC]
 **next_token** | **String**| Used for pagination when there are more ship labels than the specified result size limit. The token value is returned in the previous API call. | [optional] 

### Return type

[**ShippingLabelList**](ShippingLabelList.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, pagination, shippingLabels



# **submit_shipping_label_request**
> TransactionReference submit_shipping_label_request(body)

submitShippingLabelRequest

Creates a shipping label for a purchase order and returns a `transactionId` for reference.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 10 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values then those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'vendor-direct-fulfillment-shipping-api-model'

api_instance = AmzSpApi::VendorDirectFulfillmentShippingApiModel::VendorShippingLabelsApi.new
body = AmzSpApi::VendorDirectFulfillmentShippingApiModel::SubmitShippingLabelsRequest.new # SubmitShippingLabelsRequest | The request body that contains the shipping labels data.


begin
  #submitShippingLabelRequest
  result = api_instance.submit_shipping_label_request(body)
  p result
rescue AmzSpApi::VendorDirectFulfillmentShippingApiModel::ApiError => e
  puts "Exception when calling VendorShippingLabelsApi->submit_shipping_label_request: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**SubmitShippingLabelsRequest**](SubmitShippingLabelsRequest.md)| The request body that contains the shipping labels data. | 

### Return type

[**TransactionReference**](TransactionReference.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



