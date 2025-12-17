# AmzSpApi::ExternalFulfillmentShipments::ShipmentProcessingApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_packages**](ShipmentProcessingApi.md#create_packages) | **POST** /externalFulfillment/2024-09-11/shipments/{shipmentId}/packages | 
[**generate_invoice**](ShipmentProcessingApi.md#generate_invoice) | **POST** /externalFulfillment/2024-09-11/shipments/{shipmentId}/invoice | 
[**generate_ship_labels**](ShipmentProcessingApi.md#generate_ship_labels) | **PUT** /externalFulfillment/2024-09-11/shipments/{shipmentId}/shipLabels | 
[**process_shipment**](ShipmentProcessingApi.md#process_shipment) | **POST** /externalFulfillment/2024-09-11/shipments/{shipmentId} | 
[**retrieve_invoice**](ShipmentProcessingApi.md#retrieve_invoice) | **GET** /externalFulfillment/2024-09-11/shipments/{shipmentId}/invoice | 
[**retrieve_shipping_options**](ShipmentProcessingApi.md#retrieve_shipping_options) | **GET** /externalFulfillment/2024-09-11/shipments/{shipmentId}/shippingOptions | 
[**update_package**](ShipmentProcessingApi.md#update_package) | **PUT** /externalFulfillment/2024-09-11/shipments/{shipmentId}/packages/{packageId} | 
[**update_package_status**](ShipmentProcessingApi.md#update_package_status) | **PATCH** /externalFulfillment/2024-09-11/shipments/{shipmentId}/packages/{packageId} | 

# **create_packages**
> create_packages(bodyshipment_id)



Provide details about the packages in the specified shipment.

### Example
```ruby
# load the gem
require 'external-fulfillment-externalFulfillmentShipments'

api_instance = AmzSpApi::ExternalFulfillmentShipments::ShipmentProcessingApi.new
body = AmzSpApi::ExternalFulfillmentShipments::Packages.new # Packages | A list of packages in the shipment.
shipment_id = 'shipment_id_example' # String | The ID of the shipment.


begin
  api_instance.create_packages(bodyshipment_id)
rescue AmzSpApi::ExternalFulfillmentShipments::ApiError => e
  puts "Exception when calling ShipmentProcessingApi->create_packages: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**Packages**](Packages.md)| A list of packages in the shipment. | 
 **shipment_id** | **String**| The ID of the shipment. | 

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **generate_invoice**
> InvoiceResponse generate_invoice(shipment_id)



Get invoices for the shipment you specify.

### Example
```ruby
# load the gem
require 'external-fulfillment-externalFulfillmentShipments'

api_instance = AmzSpApi::ExternalFulfillmentShipments::ShipmentProcessingApi.new
shipment_id = 'shipment_id_example' # String | The ID of the shipment whose invoice you want.


begin
  result = api_instance.generate_invoice(shipment_id)
  p result
rescue AmzSpApi::ExternalFulfillmentShipments::ApiError => e
  puts "Exception when calling ShipmentProcessingApi->generate_invoice: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shipment_id** | **String**| The ID of the shipment whose invoice you want. | 

### Return type

[**InvoiceResponse**](InvoiceResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **generate_ship_labels**
> ShipLabelsResponse generate_ship_labels(operationshipment_id, opts)



Generate and retrieve all shipping labels for one or more packages in the shipment you specify.

### Example
```ruby
# load the gem
require 'external-fulfillment-externalFulfillmentShipments'

api_instance = AmzSpApi::ExternalFulfillmentShipments::ShipmentProcessingApi.new
operation = 'operation_example' # String | Specify whether you want to generate or regenerate a label.
shipment_id = 'shipment_id_example' # String | The ID of the shipment whose shipping labels you want to generate and retrieve.
opts = { 
  body: AmzSpApi::ExternalFulfillmentShipments::ShipLabelsInput.new # ShipLabelsInput | Shipping details for when shipping is not done by the marketplace channel.
  shipping_option_id: 'shipping_option_id_example' # String | The ID of the shipping option whose shipping labels you want.
}

begin
  result = api_instance.generate_ship_labels(operationshipment_id, opts)
  p result
rescue AmzSpApi::ExternalFulfillmentShipments::ApiError => e
  puts "Exception when calling ShipmentProcessingApi->generate_ship_labels: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **operation** | **String**| Specify whether you want to generate or regenerate a label. | 
 **shipment_id** | **String**| The ID of the shipment whose shipping labels you want to generate and retrieve. | 
 **body** | [**ShipLabelsInput**](ShipLabelsInput.md)| Shipping details for when shipping is not done by the marketplace channel. | [optional] 
 **shipping_option_id** | **String**| The ID of the shipping option whose shipping labels you want. | [optional] 

### Return type

[**ShipLabelsResponse**](ShipLabelsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **process_shipment**
> process_shipment(operationshipment_id, opts)



Confirm or reject the specified shipment.

### Example
```ruby
# load the gem
require 'external-fulfillment-externalFulfillmentShipments'

api_instance = AmzSpApi::ExternalFulfillmentShipments::ShipmentProcessingApi.new
operation = 'operation_example' # String | The status of the shipment.
shipment_id = 'shipment_id_example' # String | The ID of the shipment you want to confirm or reject.
opts = { 
  body: AmzSpApi::ExternalFulfillmentShipments::ShipmentAcknowledgementRequest.new # ShipmentAcknowledgementRequest | Information about the shipment and its line items.
}

begin
  api_instance.process_shipment(operationshipment_id, opts)
rescue AmzSpApi::ExternalFulfillmentShipments::ApiError => e
  puts "Exception when calling ShipmentProcessingApi->process_shipment: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **operation** | **String**| The status of the shipment. | 
 **shipment_id** | **String**| The ID of the shipment you want to confirm or reject. | 
 **body** | [**ShipmentAcknowledgementRequest**](ShipmentAcknowledgementRequest.md)| Information about the shipment and its line items. | [optional] 

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **retrieve_invoice**
> InvoiceResponse retrieve_invoice(shipment_id)



Retrieve invoices for the shipment you specify.

### Example
```ruby
# load the gem
require 'external-fulfillment-externalFulfillmentShipments'

api_instance = AmzSpApi::ExternalFulfillmentShipments::ShipmentProcessingApi.new
shipment_id = 'shipment_id_example' # String | The ID of the shipment whose invoice you want to retrieve.


begin
  result = api_instance.retrieve_invoice(shipment_id)
  p result
rescue AmzSpApi::ExternalFulfillmentShipments::ApiError => e
  puts "Exception when calling ShipmentProcessingApi->retrieve_invoice: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shipment_id** | **String**| The ID of the shipment whose invoice you want to retrieve. | 

### Return type

[**InvoiceResponse**](InvoiceResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **retrieve_shipping_options**
> ShippingOptionsResponse retrieve_shipping_options(shipment_id, package_id)



Get a list of shipping options for a package in a shipment given the shipment's marketplace and channel. If the marketplace and channel have a pre-determined shipping option, then this operation returns an empty response.

### Example
```ruby
# load the gem
require 'external-fulfillment-externalFulfillmentShipments'

api_instance = AmzSpApi::ExternalFulfillmentShipments::ShipmentProcessingApi.new
shipment_id = 'shipment_id_example' # String | The ID of the shipment to which the package belongs.
package_id = 'package_id_example' # String | The ID of the package for which you want to retrieve shipping options.


begin
  result = api_instance.retrieve_shipping_options(shipment_id, package_id)
  p result
rescue AmzSpApi::ExternalFulfillmentShipments::ApiError => e
  puts "Exception when calling ShipmentProcessingApi->retrieve_shipping_options: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shipment_id** | **String**| The ID of the shipment to which the package belongs. | 
 **package_id** | **String**| The ID of the package for which you want to retrieve shipping options. | 

### Return type

[**ShippingOptionsResponse**](ShippingOptionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **update_package**
> update_package(bodyshipment_idpackage_id)



Updates the details about the packages that will be used to fulfill the specified shipment.

### Example
```ruby
# load the gem
require 'external-fulfillment-externalFulfillmentShipments'

api_instance = AmzSpApi::ExternalFulfillmentShipments::ShipmentProcessingApi.new
body = AmzSpApi::ExternalFulfillmentShipments::Package.new # Package | The body of the request.
shipment_id = 'shipment_id_example' # String | The ID of the shipment to which the package belongs.
package_id = 'package_id_example' # String | The ID of the package whose information you want to update.


begin
  api_instance.update_package(bodyshipment_idpackage_id)
rescue AmzSpApi::ExternalFulfillmentShipments::ApiError => e
  puts "Exception when calling ShipmentProcessingApi->update_package: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**Package**](Package.md)| The body of the request. | 
 **shipment_id** | **String**| The ID of the shipment to which the package belongs. | 
 **package_id** | **String**| The ID of the package whose information you want to update. | 

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **update_package_status**
> update_package_status(shipment_idpackage_id, opts)



Updates the status of the packages.

### Example
```ruby
# load the gem
require 'external-fulfillment-externalFulfillmentShipments'

api_instance = AmzSpApi::ExternalFulfillmentShipments::ShipmentProcessingApi.new
shipment_id = 'shipment_id_example' # String | The ID of the shipment to which the package belongs.
package_id = 'package_id_example' # String | The ID of the package whose status you want to update.
opts = { 
  body: AmzSpApi::ExternalFulfillmentShipments::PackageDeliveryStatus.new # PackageDeliveryStatus | The body of the request.
  status: 'status_example' # String | **DEPRECATED**. Do not use. Package status is defined in the body parameter.
}

begin
  api_instance.update_package_status(shipment_idpackage_id, opts)
rescue AmzSpApi::ExternalFulfillmentShipments::ApiError => e
  puts "Exception when calling ShipmentProcessingApi->update_package_status: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shipment_id** | **String**| The ID of the shipment to which the package belongs. | 
 **package_id** | **String**| The ID of the package whose status you want to update. | 
 **body** | [**PackageDeliveryStatus**](PackageDeliveryStatus.md)| The body of the request. | [optional] 
 **status** | **String**| **DEPRECATED**. Do not use. Package status is defined in the body parameter. | [optional] 

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



