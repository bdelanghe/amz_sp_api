# AmzSpApi::VendorDirectFulfillmentShippingApiModel::2021_12_28::VendorShippingApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_packing_slip**](VendorShippingApi.md#get_packing_slip) | **GET** /vendor/directFulfillment/shipping/2021-12-28/packingSlips/{purchaseOrderNumber} | getPackingSlip
[**get_packing_slips**](VendorShippingApi.md#get_packing_slips) | **GET** /vendor/directFulfillment/shipping/2021-12-28/packingSlips | getPackingSlips
[**submit_shipment_confirmations**](VendorShippingApi.md#submit_shipment_confirmations) | **POST** /vendor/directFulfillment/shipping/2021-12-28/shipmentConfirmations | submitShipmentConfirmations
[**submit_shipment_status_updates**](VendorShippingApi.md#submit_shipment_status_updates) | **POST** /vendor/directFulfillment/shipping/2021-12-28/shipmentStatusUpdates | submitShipmentStatusUpdates

# **get_packing_slip**
> PackingSlip get_packing_slip(purchase_order_number)

getPackingSlip

Returns a packing slip based on the purchaseOrderNumber that you specify.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 10 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values then those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'vendor-direct-fulfillment-shipping-api-model'

api_instance = AmzSpApi::VendorDirectFulfillmentShippingApiModel::2021_12_28::VendorShippingApi.new
purchase_order_number = 'purchase_order_number_example' # String | The `purchaseOrderNumber` for the packing slip that you want.


begin
  #getPackingSlip
  result = api_instance.get_packing_slip(purchase_order_number)
  p result
rescue AmzSpApi::VendorDirectFulfillmentShippingApiModel::2021_12_28::ApiError => e
  puts "Exception when calling VendorShippingApi->get_packing_slip: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **purchase_order_number** | **String**| The &#x60;purchaseOrderNumber&#x60; for the packing slip that you want. | 

### Return type

[**PackingSlip**](PackingSlip.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_packing_slips**
> PackingSlipList get_packing_slips(created_after, created_before, opts)

getPackingSlips

Returns a list of packing slips for the purchase orders that match the criteria specified. Date range to search must not be more than 7 days.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 10 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values then those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'vendor-direct-fulfillment-shipping-api-model'

api_instance = AmzSpApi::VendorDirectFulfillmentShippingApiModel::2021_12_28::VendorShippingApi.new
created_after = DateTime.parse('2013-10-20T19:20:30+01:00') # DateTime | Packing slips that become available after this date and time will be included in the result. Values are in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.
created_before = DateTime.parse('2013-10-20T19:20:30+01:00') # DateTime | Packing slips that became available before this date and time will be included in the result. Values are in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.
opts = { 
  ship_from_party_id: 'ship_from_party_id_example', # String | The vendor `warehouseId` for order fulfillment. If not specified, the result contains orders for all warehouses.
  limit: 56, # Integer | The maximum number of records to return.
  sort_order: 'ASC', # String | The packing slip creation dates, which are sorted by ascending or descending order.
  next_token: 'next_token_example' # String | Used for pagination when there are more packing slips than the specified result size limit. The token value is returned in the previous API call.
}

begin
  #getPackingSlips
  result = api_instance.get_packing_slips(created_after, created_before, opts)
  p result
rescue AmzSpApi::VendorDirectFulfillmentShippingApiModel::2021_12_28::ApiError => e
  puts "Exception when calling VendorShippingApi->get_packing_slips: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **created_after** | **DateTime**| Packing slips that become available after this date and time will be included in the result. Values are in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. | 
 **created_before** | **DateTime**| Packing slips that became available before this date and time will be included in the result. Values are in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. | 
 **ship_from_party_id** | **String**| The vendor &#x60;warehouseId&#x60; for order fulfillment. If not specified, the result contains orders for all warehouses. | [optional] 
 **limit** | **Integer**| The maximum number of records to return. | [optional] 
 **sort_order** | **String**| The packing slip creation dates, which are sorted by ascending or descending order. | [optional] [default to ASC]
 **next_token** | **String**| Used for pagination when there are more packing slips than the specified result size limit. The token value is returned in the previous API call. | [optional] 

### Return type

[**PackingSlipList**](PackingSlipList.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **submit_shipment_confirmations**
> TransactionReference submit_shipment_confirmations(body)

submitShipmentConfirmations

Submits one or more shipment confirmations for vendor orders.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 10 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values then those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'vendor-direct-fulfillment-shipping-api-model'

api_instance = AmzSpApi::VendorDirectFulfillmentShippingApiModel::2021_12_28::VendorShippingApi.new
body = AmzSpApi::VendorDirectFulfillmentShippingApiModel::2021_12_28::SubmitShipmentConfirmationsRequest.new # SubmitShipmentConfirmationsRequest | Request body containing the shipment confirmations data.


begin
  #submitShipmentConfirmations
  result = api_instance.submit_shipment_confirmations(body)
  p result
rescue AmzSpApi::VendorDirectFulfillmentShippingApiModel::2021_12_28::ApiError => e
  puts "Exception when calling VendorShippingApi->submit_shipment_confirmations: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**SubmitShipmentConfirmationsRequest**](SubmitShipmentConfirmationsRequest.md)| Request body containing the shipment confirmations data. | 

### Return type

[**TransactionReference**](TransactionReference.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **submit_shipment_status_updates**
> TransactionReference submit_shipment_status_updates(body)

submitShipmentStatusUpdates

This operation is only to be used by Vendor-Own-Carrier (VOC) vendors. Calling this API submits a shipment status update for the package that a vendor has shipped. It will provide the Amazon customer visibility on their order, when the package is outside of Amazon Network visibility.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 10 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values then those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'vendor-direct-fulfillment-shipping-api-model'

api_instance = AmzSpApi::VendorDirectFulfillmentShippingApiModel::2021_12_28::VendorShippingApi.new
body = AmzSpApi::VendorDirectFulfillmentShippingApiModel::2021_12_28::SubmitShipmentStatusUpdatesRequest.new # SubmitShipmentStatusUpdatesRequest | Request body containing the shipment status update data.


begin
  #submitShipmentStatusUpdates
  result = api_instance.submit_shipment_status_updates(body)
  p result
rescue AmzSpApi::VendorDirectFulfillmentShippingApiModel::2021_12_28::ApiError => e
  puts "Exception when calling VendorShippingApi->submit_shipment_status_updates: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**SubmitShipmentStatusUpdatesRequest**](SubmitShipmentStatusUpdatesRequest.md)| Request body containing the shipment status update data. | 

### Return type

[**TransactionReference**](TransactionReference.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



