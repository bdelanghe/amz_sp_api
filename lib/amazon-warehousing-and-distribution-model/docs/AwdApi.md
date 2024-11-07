# AmzSpApi::AmazonWarehousingAndDistributionModel::AwdApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_inbound_shipment**](AwdApi.md#get_inbound_shipment) | **GET** /awd/2024-05-09/inboundShipments/{shipmentId} | 
[**list_inbound_shipments**](AwdApi.md#list_inbound_shipments) | **GET** /awd/2024-05-09/inboundShipments | 
[**list_inventory**](AwdApi.md#list_inventory) | **GET** /awd/2024-05-09/inventory | 

# **get_inbound_shipment**
> InboundShipment get_inbound_shipment(shipment_id, opts)



Retrieves an AWD inbound shipment.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api)

### Example
```ruby
# load the gem
require 'amazon-warehousing-and-distribution-model'

api_instance = AmzSpApi::AmazonWarehousingAndDistributionModel::AwdApi.new
shipment_id = 'shipment_id_example' # String | ID for the shipment. A shipment contains the cases being inbounded.
opts = { 
  sku_quantities: 'sku_quantities_example' # String | If equal to `SHOW`, the response includes the shipment SKU quantity details.  Defaults to `HIDE`, in which case the response does not contain SKU quantities
}

begin
  result = api_instance.get_inbound_shipment(shipment_id, opts)
  p result
rescue AmzSpApi::AmazonWarehousingAndDistributionModel::ApiError => e
  puts "Exception when calling AwdApi->get_inbound_shipment: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shipment_id** | **String**| ID for the shipment. A shipment contains the cases being inbounded. | 
 **sku_quantities** | **String**| If equal to &#x60;SHOW&#x60;, the response includes the shipment SKU quantity details.  Defaults to &#x60;HIDE&#x60;, in which case the response does not contain SKU quantities | [optional] 

### Return type

[**InboundShipment**](InboundShipment.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_inbound_shipments**
> ShipmentListing list_inbound_shipments(opts)



Retrieves a summary of all the inbound AWD shipments associated with a merchant, with the ability to apply optional filters.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 1 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'amazon-warehousing-and-distribution-model'

api_instance = AmzSpApi::AmazonWarehousingAndDistributionModel::AwdApi.new
opts = { 
  sort_by: 'sort_by_example', # String | Field to sort results by. By default, the response will be sorted by UPDATED_AT.
  sort_order: 'sort_order_example', # String | Sort the response in ASCENDING or DESCENDING order. By default, the response will be sorted in DESCENDING order.
  shipment_status: 'shipment_status_example', # String | Filter by inbound shipment status.
  updated_after: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | List the inbound shipments that were updated after a certain time (inclusive). The date must be in <a href='https://developer-docs.amazon.com/sp-api/docs/iso-8601'>ISO 8601</a> format.
  updated_before: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | List the inbound shipments that were updated before a certain time (inclusive). The date must be in <a href='https://developer-docs.amazon.com/sp-api/docs/iso-8601'>ISO 8601</a> format.
  max_results: 25, # Integer | Maximum number of results to return.
  next_token: 'next_token_example' # String | Token to retrieve the next set of paginated results.
}

begin
  result = api_instance.list_inbound_shipments(opts)
  p result
rescue AmzSpApi::AmazonWarehousingAndDistributionModel::ApiError => e
  puts "Exception when calling AwdApi->list_inbound_shipments: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sort_by** | **String**| Field to sort results by. By default, the response will be sorted by UPDATED_AT. | [optional] 
 **sort_order** | **String**| Sort the response in ASCENDING or DESCENDING order. By default, the response will be sorted in DESCENDING order. | [optional] 
 **shipment_status** | **String**| Filter by inbound shipment status. | [optional] 
 **updated_after** | **DateTime**| List the inbound shipments that were updated after a certain time (inclusive). The date must be in &lt;a href&#x3D;&#x27;https://developer-docs.amazon.com/sp-api/docs/iso-8601&#x27;&gt;ISO 8601&lt;/a&gt; format. | [optional] 
 **updated_before** | **DateTime**| List the inbound shipments that were updated before a certain time (inclusive). The date must be in &lt;a href&#x3D;&#x27;https://developer-docs.amazon.com/sp-api/docs/iso-8601&#x27;&gt;ISO 8601&lt;/a&gt; format. | [optional] 
 **max_results** | **Integer**| Maximum number of results to return. | [optional] [default to 25]
 **next_token** | **String**| Token to retrieve the next set of paginated results. | [optional] 

### Return type

[**ShipmentListing**](ShipmentListing.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_inventory**
> InventoryListing list_inventory(opts)



Lists AWD inventory associated with a merchant with the ability to apply optional filters.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'amazon-warehousing-and-distribution-model'

api_instance = AmzSpApi::AmazonWarehousingAndDistributionModel::AwdApi.new
opts = { 
  sku: 'sku_example', # String | Filter by seller or merchant SKU for the item.
  sort_order: 'sort_order_example', # String | Sort the response in `ASCENDING` or `DESCENDING` order.
  details: 'details_example', # String | Set to `SHOW` to return summaries with additional inventory details. Defaults to `HIDE,` which returns only inventory summary totals.
  next_token: 'next_token_example', # String | Token to retrieve the next set of paginated results.
  max_results: 25 # Integer | Maximum number of results to return.
}

begin
  result = api_instance.list_inventory(opts)
  p result
rescue AmzSpApi::AmazonWarehousingAndDistributionModel::ApiError => e
  puts "Exception when calling AwdApi->list_inventory: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sku** | **String**| Filter by seller or merchant SKU for the item. | [optional] 
 **sort_order** | **String**| Sort the response in &#x60;ASCENDING&#x60; or &#x60;DESCENDING&#x60; order. | [optional] 
 **details** | **String**| Set to &#x60;SHOW&#x60; to return summaries with additional inventory details. Defaults to &#x60;HIDE,&#x60; which returns only inventory summary totals. | [optional] 
 **next_token** | **String**| Token to retrieve the next set of paginated results. | [optional] 
 **max_results** | **Integer**| Maximum number of results to return. | [optional] [default to 25]

### Return type

[**InventoryListing**](InventoryListing.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



