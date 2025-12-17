# AmzSpApi::ExternalFulfillmentShipments::ShipmentRetrievalApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_shipment**](ShipmentRetrievalApi.md#get_shipment) | **GET** /externalFulfillment/2024-09-11/shipments/{shipmentId} | 
[**get_shipments**](ShipmentRetrievalApi.md#get_shipments) | **GET** /externalFulfillment/2024-09-11/shipments | 

# **get_shipment**
> Shipment get_shipment(shipment_id)



Get a single shipment with the ID you specify.

### Example
```ruby
# load the gem
require 'external-fulfillment-externalFulfillmentShipments'

api_instance = AmzSpApi::ExternalFulfillmentShipments::ShipmentRetrievalApi.new
shipment_id = 'shipment_id_example' # String | The ID of the shipment you want to retrieve.


begin
  result = api_instance.get_shipment(shipment_id)
  p result
rescue AmzSpApi::ExternalFulfillmentShipments::ApiError => e
  puts "Exception when calling ShipmentRetrievalApi->get_shipment: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shipment_id** | **String**| The ID of the shipment you want to retrieve. | 

### Return type

[**Shipment**](Shipment.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_shipments**
> ShipmentsResponse get_shipments(status, opts)



Get a list of shipments created for the seller in the status you specify. Shipments can be further filtered based on the fulfillment node or the time of the shipments' last update.

### Example
```ruby
# load the gem
require 'external-fulfillment-externalFulfillmentShipments'

api_instance = AmzSpApi::ExternalFulfillmentShipments::ShipmentRetrievalApi.new
status = 'status_example' # String | The status of shipment you want to include in the response. To retrieve all new shipments, set this value to `ACCEPTED`.
opts = { 
  location_id: 'location_id_example', # String | The Amazon channel location identifier for the shipments you want to retrieve.
  marketplace_id: 'marketplace_id_example', # String | The marketplace ID associated with the location. To find the ID for your marketplace, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids).
  channel_name: 'channel_name_example', # String | The channel name associated with the location.
  last_updated_after: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | The response includes shipments whose latest update is after the specified time. In [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.
  last_updated_before: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | The response includes shipments whose latest update is before the specified time. In [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.
  max_results: 56, # Integer | The maximum number of shipments to include in the response.
  pagination_token: 'pagination_token_example' # String | A token that you use to retrieve the next page of results. The response includes `nextToken` when there are multiple pages of results. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until `nextToken` is null. Note that this operation can return empty pages.
}

begin
  result = api_instance.get_shipments(status, opts)
  p result
rescue AmzSpApi::ExternalFulfillmentShipments::ApiError => e
  puts "Exception when calling ShipmentRetrievalApi->get_shipments: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**| The status of shipment you want to include in the response. To retrieve all new shipments, set this value to &#x60;ACCEPTED&#x60;. | 
 **location_id** | **String**| The Amazon channel location identifier for the shipments you want to retrieve. | [optional] 
 **marketplace_id** | **String**| The marketplace ID associated with the location. To find the ID for your marketplace, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids). | [optional] 
 **channel_name** | **String**| The channel name associated with the location. | [optional] 
 **last_updated_after** | **DateTime**| The response includes shipments whose latest update is after the specified time. In [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. | [optional] 
 **last_updated_before** | **DateTime**| The response includes shipments whose latest update is before the specified time. In [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. | [optional] 
 **max_results** | **Integer**| The maximum number of shipments to include in the response. | [optional] 
 **pagination_token** | **String**| A token that you use to retrieve the next page of results. The response includes &#x60;nextToken&#x60; when there are multiple pages of results. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until &#x60;nextToken&#x60; is null. Note that this operation can return empty pages. | [optional] 

### Return type

[**ShipmentsResponse**](ShipmentsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



