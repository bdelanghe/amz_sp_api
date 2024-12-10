# AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cancel_inbound_plan**](FulfillmentInboundApi.md#cancel_inbound_plan) | **PUT** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/cancellation | cancelInboundPlan
[**cancel_self_ship_appointment**](FulfillmentInboundApi.md#cancel_self_ship_appointment) | **PUT** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/selfShipAppointmentCancellation | cancelSelfShipAppointment
[**confirm_delivery_window_options**](FulfillmentInboundApi.md#confirm_delivery_window_options) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/deliveryWindowOptions/{deliveryWindowOptionId}/confirmation | confirmDeliveryWindowOptions
[**confirm_packing_option**](FulfillmentInboundApi.md#confirm_packing_option) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/packingOptions/{packingOptionId}/confirmation | confirmPackingOption
[**confirm_placement_option**](FulfillmentInboundApi.md#confirm_placement_option) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/placementOptions/{placementOptionId}/confirmation | confirmPlacementOption
[**confirm_shipment_content_update_preview**](FulfillmentInboundApi.md#confirm_shipment_content_update_preview) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/contentUpdatePreviews/{contentUpdatePreviewId}/confirmation | confirmShipmentContentUpdatePreview
[**confirm_transportation_options**](FulfillmentInboundApi.md#confirm_transportation_options) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/transportationOptions/confirmation | confirmTransportationOptions
[**create_inbound_plan**](FulfillmentInboundApi.md#create_inbound_plan) | **POST** /inbound/fba/2024-03-20/inboundPlans | createInboundPlan
[**create_marketplace_item_labels**](FulfillmentInboundApi.md#create_marketplace_item_labels) | **POST** /inbound/fba/2024-03-20/items/labels | createMarketplaceItemLabels
[**generate_delivery_window_options**](FulfillmentInboundApi.md#generate_delivery_window_options) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/deliveryWindowOptions | generateDeliveryWindowOptions
[**generate_packing_options**](FulfillmentInboundApi.md#generate_packing_options) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/packingOptions | generatePackingOptions
[**generate_placement_options**](FulfillmentInboundApi.md#generate_placement_options) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/placementOptions | generatePlacementOptions
[**generate_self_ship_appointment_slots**](FulfillmentInboundApi.md#generate_self_ship_appointment_slots) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/selfShipAppointmentSlots | generateSelfShipAppointmentSlots
[**generate_shipment_content_update_previews**](FulfillmentInboundApi.md#generate_shipment_content_update_previews) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/contentUpdatePreviews | generateShipmentContentUpdatePreviews
[**generate_transportation_options**](FulfillmentInboundApi.md#generate_transportation_options) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/transportationOptions | generateTransportationOptions
[**get_delivery_challan_document**](FulfillmentInboundApi.md#get_delivery_challan_document) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/deliveryChallanDocument | getDeliveryChallanDocument
[**get_inbound_operation_status**](FulfillmentInboundApi.md#get_inbound_operation_status) | **GET** /inbound/fba/2024-03-20/operations/{operationId} | getInboundOperationStatus
[**get_inbound_plan**](FulfillmentInboundApi.md#get_inbound_plan) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId} | getInboundPlan
[**get_self_ship_appointment_slots**](FulfillmentInboundApi.md#get_self_ship_appointment_slots) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/selfShipAppointmentSlots | getSelfShipAppointmentSlots
[**get_shipment**](FulfillmentInboundApi.md#get_shipment) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId} | getShipment
[**get_shipment_content_update_preview**](FulfillmentInboundApi.md#get_shipment_content_update_preview) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/contentUpdatePreviews/{contentUpdatePreviewId} | getShipmentContentUpdatePreview
[**list_delivery_window_options**](FulfillmentInboundApi.md#list_delivery_window_options) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/deliveryWindowOptions | listDeliveryWindowOptions
[**list_inbound_plan_boxes**](FulfillmentInboundApi.md#list_inbound_plan_boxes) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/boxes | listInboundPlanBoxes
[**list_inbound_plan_items**](FulfillmentInboundApi.md#list_inbound_plan_items) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/items | listInboundPlanItems
[**list_inbound_plan_pallets**](FulfillmentInboundApi.md#list_inbound_plan_pallets) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/pallets | listInboundPlanPallets
[**list_inbound_plans**](FulfillmentInboundApi.md#list_inbound_plans) | **GET** /inbound/fba/2024-03-20/inboundPlans | listInboundPlans
[**list_item_compliance_details**](FulfillmentInboundApi.md#list_item_compliance_details) | **GET** /inbound/fba/2024-03-20/items/compliance | listItemComplianceDetails
[**list_packing_group_boxes**](FulfillmentInboundApi.md#list_packing_group_boxes) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/packingGroups/{packingGroupId}/boxes | listPackingGroupBoxes
[**list_packing_group_items**](FulfillmentInboundApi.md#list_packing_group_items) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/packingGroups/{packingGroupId}/items | listPackingGroupItems
[**list_packing_options**](FulfillmentInboundApi.md#list_packing_options) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/packingOptions | listPackingOptions
[**list_placement_options**](FulfillmentInboundApi.md#list_placement_options) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/placementOptions | listPlacementOptions
[**list_prep_details**](FulfillmentInboundApi.md#list_prep_details) | **GET** /inbound/fba/2024-03-20/items/prepDetails | listPrepDetails
[**list_shipment_boxes**](FulfillmentInboundApi.md#list_shipment_boxes) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/boxes | listShipmentBoxes
[**list_shipment_content_update_previews**](FulfillmentInboundApi.md#list_shipment_content_update_previews) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/contentUpdatePreviews | listShipmentContentUpdatePreviews
[**list_shipment_items**](FulfillmentInboundApi.md#list_shipment_items) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/items | listShipmentItems
[**list_shipment_pallets**](FulfillmentInboundApi.md#list_shipment_pallets) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/pallets | listShipmentPallets
[**list_transportation_options**](FulfillmentInboundApi.md#list_transportation_options) | **GET** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/transportationOptions | listTransportationOptions
[**schedule_self_ship_appointment**](FulfillmentInboundApi.md#schedule_self_ship_appointment) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/selfShipAppointmentSlots/{slotId}/schedule | scheduleSelfShipAppointment
[**set_packing_information**](FulfillmentInboundApi.md#set_packing_information) | **POST** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/packingInformation | setPackingInformation
[**set_prep_details**](FulfillmentInboundApi.md#set_prep_details) | **POST** /inbound/fba/2024-03-20/items/prepDetails | setPrepDetails
[**update_inbound_plan_name**](FulfillmentInboundApi.md#update_inbound_plan_name) | **PUT** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/name | updateInboundPlanName
[**update_item_compliance_details**](FulfillmentInboundApi.md#update_item_compliance_details) | **PUT** /inbound/fba/2024-03-20/items/compliance | updateItemComplianceDetails
[**update_shipment_name**](FulfillmentInboundApi.md#update_shipment_name) | **PUT** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/name | updateShipmentName
[**update_shipment_source_address**](FulfillmentInboundApi.md#update_shipment_source_address) | **PUT** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/sourceAddress | updateShipmentSourceAddress
[**update_shipment_tracking_details**](FulfillmentInboundApi.md#update_shipment_tracking_details) | **PUT** /inbound/fba/2024-03-20/inboundPlans/{inboundPlanId}/shipments/{shipmentId}/trackingDetails | updateShipmentTrackingDetails

# **cancel_inbound_plan**
> CancelInboundPlanResponse cancel_inbound_plan(inbound_plan_id)

cancelInboundPlan

Cancels an Inbound Plan. Charges may apply if the cancellation is performed outside of a void window. The window for Amazon Partnered Carriers is 24 hours for Small Parcel Delivery (SPD) and one hour for Less-Than-Truckload (LTL) carrier shipments.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.


begin
  #cancelInboundPlan
  result = api_instance.cancel_inbound_plan(inbound_plan_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->cancel_inbound_plan: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 

### Return type

[**CancelInboundPlanResponse**](CancelInboundPlanResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **cancel_self_ship_appointment**
> CancelSelfShipAppointmentResponse cancel_self_ship_appointment(bodyinbound_plan_idshipment_id)

cancelSelfShipAppointment

Cancels a self-ship appointment slot against a shipment.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::CancelSelfShipAppointmentRequest.new # CancelSelfShipAppointmentRequest | The body of the request to `cancelSelfShipAppointment`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.


begin
  #cancelSelfShipAppointment
  result = api_instance.cancel_self_ship_appointment(bodyinbound_plan_idshipment_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->cancel_self_ship_appointment: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CancelSelfShipAppointmentRequest**](CancelSelfShipAppointmentRequest.md)| The body of the request to &#x60;cancelSelfShipAppointment&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 

### Return type

[**CancelSelfShipAppointmentResponse**](CancelSelfShipAppointmentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **confirm_delivery_window_options**
> ConfirmDeliveryWindowOptionsResponse confirm_delivery_window_options(inbound_plan_id, shipment_id, delivery_window_option_id)

confirmDeliveryWindowOptions

Confirms the delivery window option for chosen shipment within an inbound plan. A placement option must be confirmed prior to use of this API. Once confirmed, new delivery window options cannot be generated, but the chosen delivery window option can be updated before shipment closure. The window is used to provide the expected time when a shipment will arrive at the warehouse. All transportation options which have the program `CONFIRMED_DELIVERY_WINDOW` require a delivery window to be confirmed prior to transportation option confirmation.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | The shipment to confirm the delivery window option for.
delivery_window_option_id = 'delivery_window_option_id_example' # String | The id of the delivery window option to be confirmed.


begin
  #confirmDeliveryWindowOptions
  result = api_instance.confirm_delivery_window_options(inbound_plan_id, shipment_id, delivery_window_option_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->confirm_delivery_window_options: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| The shipment to confirm the delivery window option for. | 
 **delivery_window_option_id** | **String**| The id of the delivery window option to be confirmed. | 

### Return type

[**ConfirmDeliveryWindowOptionsResponse**](ConfirmDeliveryWindowOptionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **confirm_packing_option**
> ConfirmPackingOptionResponse confirm_packing_option(inbound_plan_id, packing_option_id)

confirmPackingOption

Confirms the packing option for an inbound plan.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
packing_option_id = 'packing_option_id_example' # String | Identifier of a packing option.


begin
  #confirmPackingOption
  result = api_instance.confirm_packing_option(inbound_plan_id, packing_option_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->confirm_packing_option: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **packing_option_id** | **String**| Identifier of a packing option. | 

### Return type

[**ConfirmPackingOptionResponse**](ConfirmPackingOptionResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **confirm_placement_option**
> ConfirmPlacementOptionResponse confirm_placement_option(inbound_plan_id, placement_option_id)

confirmPlacementOption

Confirms the placement option for an inbound plan. Once confirmed, it cannot be changed for the Inbound Plan.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
placement_option_id = 'placement_option_id_example' # String | The identifier of a placement option. A placement option represents the shipment splits and destinations of SKUs.


begin
  #confirmPlacementOption
  result = api_instance.confirm_placement_option(inbound_plan_id, placement_option_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->confirm_placement_option: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **placement_option_id** | **String**| The identifier of a placement option. A placement option represents the shipment splits and destinations of SKUs. | 

### Return type

[**ConfirmPlacementOptionResponse**](ConfirmPlacementOptionResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **confirm_shipment_content_update_preview**
> ConfirmShipmentContentUpdatePreviewResponse confirm_shipment_content_update_preview(inbound_plan_id, shipment_id, content_update_preview_id)

confirmShipmentContentUpdatePreview

Confirm a shipment content update preview and accept the changes in transportation cost.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.
content_update_preview_id = 'content_update_preview_id_example' # String | Identifier of a content update preview.


begin
  #confirmShipmentContentUpdatePreview
  result = api_instance.confirm_shipment_content_update_preview(inbound_plan_id, shipment_id, content_update_preview_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->confirm_shipment_content_update_preview: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 
 **content_update_preview_id** | **String**| Identifier of a content update preview. | 

### Return type

[**ConfirmShipmentContentUpdatePreviewResponse**](ConfirmShipmentContentUpdatePreviewResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **confirm_transportation_options**
> ConfirmTransportationOptionsResponse confirm_transportation_options(bodyinbound_plan_id)

confirmTransportationOptions

Confirms all the transportation options for an inbound plan. A placement option must be confirmed prior to use of this API. Once confirmed, new transportation options can not be generated or confirmed for the Inbound Plan.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::ConfirmTransportationOptionsRequest.new # ConfirmTransportationOptionsRequest | The body of the request to `confirmTransportationOptions`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.


begin
  #confirmTransportationOptions
  result = api_instance.confirm_transportation_options(bodyinbound_plan_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->confirm_transportation_options: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ConfirmTransportationOptionsRequest**](ConfirmTransportationOptionsRequest.md)| The body of the request to &#x60;confirmTransportationOptions&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 

### Return type

[**ConfirmTransportationOptionsResponse**](ConfirmTransportationOptionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **create_inbound_plan**
> CreateInboundPlanResponse create_inbound_plan(body)

createInboundPlan

Creates an inbound plan. An inbound plan contains all the necessary information to send shipments into Amazon's fufillment network.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::CreateInboundPlanRequest.new # CreateInboundPlanRequest | The body of the request to `createInboundPlan`.


begin
  #createInboundPlan
  result = api_instance.create_inbound_plan(body)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->create_inbound_plan: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CreateInboundPlanRequest**](CreateInboundPlanRequest.md)| The body of the request to &#x60;createInboundPlan&#x60;. | 

### Return type

[**CreateInboundPlanResponse**](CreateInboundPlanResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **create_marketplace_item_labels**
> CreateMarketplaceItemLabelsResponse create_marketplace_item_labels(body)

createMarketplaceItemLabels

For a given marketplace - creates labels for a list of MSKUs.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::CreateMarketplaceItemLabelsRequest.new # CreateMarketplaceItemLabelsRequest | The body of the request to `createMarketplaceItemLabels`.


begin
  #createMarketplaceItemLabels
  result = api_instance.create_marketplace_item_labels(body)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->create_marketplace_item_labels: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CreateMarketplaceItemLabelsRequest**](CreateMarketplaceItemLabelsRequest.md)| The body of the request to &#x60;createMarketplaceItemLabels&#x60;. | 

### Return type

[**CreateMarketplaceItemLabelsResponse**](CreateMarketplaceItemLabelsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **generate_delivery_window_options**
> GenerateDeliveryWindowOptionsResponse generate_delivery_window_options(inbound_plan_id, shipment_id)

generateDeliveryWindowOptions

Generates available delivery window options for a given shipment.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | The shipment to generate delivery window options for.


begin
  #generateDeliveryWindowOptions
  result = api_instance.generate_delivery_window_options(inbound_plan_id, shipment_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->generate_delivery_window_options: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| The shipment to generate delivery window options for. | 

### Return type

[**GenerateDeliveryWindowOptionsResponse**](GenerateDeliveryWindowOptionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **generate_packing_options**
> GeneratePackingOptionsResponse generate_packing_options(inbound_plan_id)

generatePackingOptions

Generates available packing options for the inbound plan.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.


begin
  #generatePackingOptions
  result = api_instance.generate_packing_options(inbound_plan_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->generate_packing_options: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 

### Return type

[**GeneratePackingOptionsResponse**](GeneratePackingOptionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **generate_placement_options**
> GeneratePlacementOptionsResponse generate_placement_options(bodyinbound_plan_id)

generatePlacementOptions

Generates placement options for the inbound plan.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::GeneratePlacementOptionsRequest.new # GeneratePlacementOptionsRequest | The body of the request to `generatePlacementOptions`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.


begin
  #generatePlacementOptions
  result = api_instance.generate_placement_options(bodyinbound_plan_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->generate_placement_options: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**GeneratePlacementOptionsRequest**](GeneratePlacementOptionsRequest.md)| The body of the request to &#x60;generatePlacementOptions&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 

### Return type

[**GeneratePlacementOptionsResponse**](GeneratePlacementOptionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **generate_self_ship_appointment_slots**
> GenerateSelfShipAppointmentSlotsResponse generate_self_ship_appointment_slots(bodyinbound_plan_idshipment_id)

generateSelfShipAppointmentSlots

Initiates the process of generating the appointment slots list.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::GenerateSelfShipAppointmentSlotsRequest.new # GenerateSelfShipAppointmentSlotsRequest | The body of the request to `generateSelfShipAppointmentSlots`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.


begin
  #generateSelfShipAppointmentSlots
  result = api_instance.generate_self_ship_appointment_slots(bodyinbound_plan_idshipment_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->generate_self_ship_appointment_slots: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**GenerateSelfShipAppointmentSlotsRequest**](GenerateSelfShipAppointmentSlotsRequest.md)| The body of the request to &#x60;generateSelfShipAppointmentSlots&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 

### Return type

[**GenerateSelfShipAppointmentSlotsResponse**](GenerateSelfShipAppointmentSlotsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **generate_shipment_content_update_previews**
> GenerateShipmentContentUpdatePreviewsResponse generate_shipment_content_update_previews(bodyinbound_plan_idshipment_id)

generateShipmentContentUpdatePreviews

Generate a shipment content update preview given a set of intended boxes and/or items for a shipment with a confirmed carrier. The shipment content update preview will be viewable with the updated costs and contents prior to confirmation.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::GenerateShipmentContentUpdatePreviewsRequest.new # GenerateShipmentContentUpdatePreviewsRequest | The body of the request to `generateShipmentContentUpdatePreviews`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.


begin
  #generateShipmentContentUpdatePreviews
  result = api_instance.generate_shipment_content_update_previews(bodyinbound_plan_idshipment_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->generate_shipment_content_update_previews: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**GenerateShipmentContentUpdatePreviewsRequest**](GenerateShipmentContentUpdatePreviewsRequest.md)| The body of the request to &#x60;generateShipmentContentUpdatePreviews&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 

### Return type

[**GenerateShipmentContentUpdatePreviewsResponse**](GenerateShipmentContentUpdatePreviewsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **generate_transportation_options**
> GenerateTransportationOptionsResponse generate_transportation_options(bodyinbound_plan_id)

generateTransportationOptions

Generates available transportation options for a given placement option.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::GenerateTransportationOptionsRequest.new # GenerateTransportationOptionsRequest | The body of the request to `generateTransportationOptions`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.


begin
  #generateTransportationOptions
  result = api_instance.generate_transportation_options(bodyinbound_plan_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->generate_transportation_options: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**GenerateTransportationOptionsRequest**](GenerateTransportationOptionsRequest.md)| The body of the request to &#x60;generateTransportationOptions&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 

### Return type

[**GenerateTransportationOptionsResponse**](GenerateTransportationOptionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_delivery_challan_document**
> GetDeliveryChallanDocumentResponse get_delivery_challan_document(inbound_plan_id, shipment_id)

getDeliveryChallanDocument

Provide delivery challan document for PCP transportation in IN marketplace.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.


begin
  #getDeliveryChallanDocument
  result = api_instance.get_delivery_challan_document(inbound_plan_id, shipment_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->get_delivery_challan_document: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 

### Return type

[**GetDeliveryChallanDocumentResponse**](GetDeliveryChallanDocumentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_inbound_operation_status**
> InboundOperationStatus get_inbound_operation_status(operation_id)

getInboundOperationStatus

Gets the status of the processing of an asynchronous API call.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
operation_id = 'operation_id_example' # String | Identifier of an asynchronous operation.


begin
  #getInboundOperationStatus
  result = api_instance.get_inbound_operation_status(operation_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->get_inbound_operation_status: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **operation_id** | **String**| Identifier of an asynchronous operation. | 

### Return type

[**InboundOperationStatus**](InboundOperationStatus.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_inbound_plan**
> InboundPlan get_inbound_plan(inbound_plan_id)

getInboundPlan

Fetches the top level information about an inbound plan.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.


begin
  #getInboundPlan
  result = api_instance.get_inbound_plan(inbound_plan_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->get_inbound_plan: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 

### Return type

[**InboundPlan**](InboundPlan.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_self_ship_appointment_slots**
> GetSelfShipAppointmentSlotsResponse get_self_ship_appointment_slots(inbound_plan_id, shipment_id, opts)

getSelfShipAppointmentSlots

Retrieves a list of available self-ship appointment slots used to drop off a shipment at a warehouse.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.
opts = { 
  page_size: 10, # Integer | The number of self ship appointment slots to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #getSelfShipAppointmentSlots
  result = api_instance.get_self_ship_appointment_slots(inbound_plan_id, shipment_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->get_self_ship_appointment_slots: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 
 **page_size** | **Integer**| The number of self ship appointment slots to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**GetSelfShipAppointmentSlotsResponse**](GetSelfShipAppointmentSlotsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_shipment**
> Shipment get_shipment(inbound_plan_id, shipment_id)

getShipment

Provides the full details for a specific shipment within an inbound plan. The `transportationOptionId` inside `acceptedTransportationSelection` can be used to retrieve the transportation details for the shipment.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.


begin
  #getShipment
  result = api_instance.get_shipment(inbound_plan_id, shipment_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->get_shipment: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 

### Return type

[**Shipment**](Shipment.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_shipment_content_update_preview**
> ContentUpdatePreview get_shipment_content_update_preview(inbound_plan_id, shipment_id, content_update_preview_id)

getShipmentContentUpdatePreview

Retrieve a shipment content update preview which provides a summary of the requested shipment content changes along with the transportation cost implications of the change that can only be confirmed prior to the expiry date specified.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.
content_update_preview_id = 'content_update_preview_id_example' # String | Identifier of a content update preview.


begin
  #getShipmentContentUpdatePreview
  result = api_instance.get_shipment_content_update_preview(inbound_plan_id, shipment_id, content_update_preview_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->get_shipment_content_update_preview: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 
 **content_update_preview_id** | **String**| Identifier of a content update preview. | 

### Return type

[**ContentUpdatePreview**](ContentUpdatePreview.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_delivery_window_options**
> ListDeliveryWindowOptionsResponse list_delivery_window_options(inbound_plan_id, shipment_id, opts)

listDeliveryWindowOptions

Retrieves all delivery window options for a shipment. Delivery window options must first be generated by the `generateDeliveryWindowOptions` operation before becoming available.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | The shipment to get delivery window options for.
opts = { 
  page_size: 10, # Integer | The number of delivery window options to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listDeliveryWindowOptions
  result = api_instance.list_delivery_window_options(inbound_plan_id, shipment_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_delivery_window_options: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| The shipment to get delivery window options for. | 
 **page_size** | **Integer**| The number of delivery window options to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListDeliveryWindowOptionsResponse**](ListDeliveryWindowOptionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_inbound_plan_boxes**
> ListInboundPlanBoxesResponse list_inbound_plan_boxes(inbound_plan_id, opts)

listInboundPlanBoxes

Provides a paginated list of box packages in an inbound plan.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
opts = { 
  page_size: 10, # Integer | The number of boxes to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listInboundPlanBoxes
  result = api_instance.list_inbound_plan_boxes(inbound_plan_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_inbound_plan_boxes: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **page_size** | **Integer**| The number of boxes to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListInboundPlanBoxesResponse**](ListInboundPlanBoxesResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_inbound_plan_items**
> ListInboundPlanItemsResponse list_inbound_plan_items(inbound_plan_id, opts)

listInboundPlanItems

Provides a paginated list of item packages in an inbound plan.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
opts = { 
  page_size: 10, # Integer | The number of items to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listInboundPlanItems
  result = api_instance.list_inbound_plan_items(inbound_plan_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_inbound_plan_items: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **page_size** | **Integer**| The number of items to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListInboundPlanItemsResponse**](ListInboundPlanItemsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_inbound_plan_pallets**
> ListInboundPlanPalletsResponse list_inbound_plan_pallets(inbound_plan_id, opts)

listInboundPlanPallets

Provides a paginated list of pallet packages in an inbound plan. An inbound plan will have pallets when the related details are provided after generating Less-Than-Truckload (LTL) carrier shipments.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
opts = { 
  page_size: 10, # Integer | The number of pallets to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listInboundPlanPallets
  result = api_instance.list_inbound_plan_pallets(inbound_plan_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_inbound_plan_pallets: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **page_size** | **Integer**| The number of pallets to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListInboundPlanPalletsResponse**](ListInboundPlanPalletsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_inbound_plans**
> ListInboundPlansResponse list_inbound_plans(opts)

listInboundPlans

Provides a list of inbound plans with minimal information.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
opts = { 
  page_size: 10, # Integer | The number of inbound plans to return in the response matching the given query.
  pagination_token: 'pagination_token_example', # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
  status: 'status_example', # String | The status of an inbound plan.
  sort_by: 'sort_by_example', # String | Sort by field.
  sort_order: 'sort_order_example' # String | The sort order.
}

begin
  #listInboundPlans
  result = api_instance.list_inbound_plans(opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_inbound_plans: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page_size** | **Integer**| The number of inbound plans to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 
 **status** | **String**| The status of an inbound plan. | [optional] 
 **sort_by** | **String**| Sort by field. | [optional] 
 **sort_order** | **String**| The sort order. | [optional] 

### Return type

[**ListInboundPlansResponse**](ListInboundPlansResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_item_compliance_details**
> ListItemComplianceDetailsResponse list_item_compliance_details(mskus, marketplace_id)

listItemComplianceDetails

List the inbound compliance details for MSKUs in a given marketplace.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
mskus = ['mskus_example'] # Array<String> | A list of merchant SKUs, a merchant-supplied identifier of a specific SKU.
marketplace_id = 'marketplace_id_example' # String | The Marketplace ID. For a list of possible values, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids).


begin
  #listItemComplianceDetails
  result = api_instance.list_item_compliance_details(mskus, marketplace_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_item_compliance_details: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mskus** | [**Array&lt;String&gt;**](String.md)| A list of merchant SKUs, a merchant-supplied identifier of a specific SKU. | 
 **marketplace_id** | **String**| The Marketplace ID. For a list of possible values, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids). | 

### Return type

[**ListItemComplianceDetailsResponse**](ListItemComplianceDetailsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_packing_group_boxes**
> ListPackingGroupBoxesResponse list_packing_group_boxes(inbound_plan_id, packing_group_id, opts)

listPackingGroupBoxes

Retrieves a page of boxes from a given packing group. These boxes were previously provided through the `setPackingInformation` operation. This API is used for workflows where boxes are packed before Amazon determines shipment splits.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
packing_group_id = 'packing_group_id_example' # String | Identifier of a packing group.
opts = { 
  page_size: 10, # Integer | The number of packing group boxes to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listPackingGroupBoxes
  result = api_instance.list_packing_group_boxes(inbound_plan_id, packing_group_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_packing_group_boxes: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **packing_group_id** | **String**| Identifier of a packing group. | 
 **page_size** | **Integer**| The number of packing group boxes to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListPackingGroupBoxesResponse**](ListPackingGroupBoxesResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_packing_group_items**
> ListPackingGroupItemsResponse list_packing_group_items(inbound_plan_id, packing_group_id, opts)

listPackingGroupItems

Retrieves a page of items in a given packing group. Packing options must first be generated by the corresponding operation before packing group items can be listed.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
packing_group_id = 'packing_group_id_example' # String | Identifier of a packing group.
opts = { 
  page_size: 10, # Integer | The number of packing group items to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listPackingGroupItems
  result = api_instance.list_packing_group_items(inbound_plan_id, packing_group_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_packing_group_items: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **packing_group_id** | **String**| Identifier of a packing group. | 
 **page_size** | **Integer**| The number of packing group items to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListPackingGroupItemsResponse**](ListPackingGroupItemsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_packing_options**
> ListPackingOptionsResponse list_packing_options(inbound_plan_id, opts)

listPackingOptions

Retrieves a list of all packing options for an inbound plan. Packing options must first be generated by the corresponding operation before becoming available.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
opts = { 
  page_size: 10, # Integer | The number of packing options to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listPackingOptions
  result = api_instance.list_packing_options(inbound_plan_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_packing_options: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **page_size** | **Integer**| The number of packing options to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListPackingOptionsResponse**](ListPackingOptionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_placement_options**
> ListPlacementOptionsResponse list_placement_options(inbound_plan_id, opts)

listPlacementOptions

Provides a list of all placement options for an inbound plan. Placement options must first be generated by the corresponding operation before becoming available.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
opts = { 
  page_size: 10, # Integer | The number of placement options to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listPlacementOptions
  result = api_instance.list_placement_options(inbound_plan_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_placement_options: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **page_size** | **Integer**| The number of placement options to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListPlacementOptionsResponse**](ListPlacementOptionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_prep_details**
> ListPrepDetailsResponse list_prep_details(marketplace_id, mskus)

listPrepDetails

Get preparation details for a list of MSKUs in a specified marketplace.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
marketplace_id = 'marketplace_id_example' # String | The marketplace ID. For a list of possible values, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids).
mskus = ['mskus_example'] # Array<String> | A list of merchant SKUs, a merchant-supplied identifier of a specific SKU.


begin
  #listPrepDetails
  result = api_instance.list_prep_details(marketplace_id, mskus)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_prep_details: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **marketplace_id** | **String**| The marketplace ID. For a list of possible values, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids). | 
 **mskus** | [**Array&lt;String&gt;**](String.md)| A list of merchant SKUs, a merchant-supplied identifier of a specific SKU. | 

### Return type

[**ListPrepDetailsResponse**](ListPrepDetailsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_shipment_boxes**
> ListShipmentBoxesResponse list_shipment_boxes(inbound_plan_id, shipment_id, opts)

listShipmentBoxes

Provides a paginated list of box packages in a shipment.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.
opts = { 
  page_size: 10, # Integer | The number of boxes to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listShipmentBoxes
  result = api_instance.list_shipment_boxes(inbound_plan_id, shipment_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_shipment_boxes: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 
 **page_size** | **Integer**| The number of boxes to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListShipmentBoxesResponse**](ListShipmentBoxesResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_shipment_content_update_previews**
> ListShipmentContentUpdatePreviewsResponse list_shipment_content_update_previews(inbound_plan_id, shipment_id, opts)

listShipmentContentUpdatePreviews

Retrieve a paginated list of shipment content update previews for a given shipment. The shipment content update preview is a summary of the requested shipment content changes along with the transportation cost implications of the change that can only be confirmed prior to the expiry date specified.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.
opts = { 
  page_size: 10, # Integer | The number of content update previews to return.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listShipmentContentUpdatePreviews
  result = api_instance.list_shipment_content_update_previews(inbound_plan_id, shipment_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_shipment_content_update_previews: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 
 **page_size** | **Integer**| The number of content update previews to return. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListShipmentContentUpdatePreviewsResponse**](ListShipmentContentUpdatePreviewsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_shipment_items**
> ListShipmentItemsResponse list_shipment_items(inbound_plan_id, shipment_id, opts)

listShipmentItems

Provides a paginated list of item packages in a shipment.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.
opts = { 
  page_size: 10, # Integer | The number of items to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listShipmentItems
  result = api_instance.list_shipment_items(inbound_plan_id, shipment_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_shipment_items: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 
 **page_size** | **Integer**| The number of items to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListShipmentItemsResponse**](ListShipmentItemsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_shipment_pallets**
> ListShipmentPalletsResponse list_shipment_pallets(inbound_plan_id, shipment_id, opts)

listShipmentPallets

Provides a paginated list of pallet packages in a shipment. A palletized shipment will have pallets when the related details are provided after generating Less-Than-Truckload (LTL) carrier shipments.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.
opts = { 
  page_size: 10, # Integer | The number of pallets to return in the response matching the given query.
  pagination_token: 'pagination_token_example' # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
}

begin
  #listShipmentPallets
  result = api_instance.list_shipment_pallets(inbound_plan_id, shipment_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_shipment_pallets: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 
 **page_size** | **Integer**| The number of pallets to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 

### Return type

[**ListShipmentPalletsResponse**](ListShipmentPalletsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_transportation_options**
> ListTransportationOptionsResponse list_transportation_options(inbound_plan_id, opts)

listTransportationOptions

Retrieves all transportation options for a shipment. Transportation options must first be generated by the `generateTransportationOptions` operation before becoming available.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
opts = { 
  page_size: 10, # Integer | The number of transportation options to return in the response matching the given query.
  pagination_token: 'pagination_token_example', # String | A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the `pagination` returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result.
  placement_option_id: 'placement_option_id_example', # String | The placement option to get transportation options for. Either `placementOptionId` or `shipmentId` must be specified.
  shipment_id: 'shipment_id_example' # String | The shipment to get transportation options for. Either `placementOptionId` or `shipmentId` must be specified.
}

begin
  #listTransportationOptions
  result = api_instance.list_transportation_options(inbound_plan_id, opts)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->list_transportation_options: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **page_size** | **Integer**| The number of transportation options to return in the response matching the given query. | [optional] [default to 10]
 **pagination_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. The value of this token is fetched from the &#x60;pagination&#x60; returned in the API response. In the absence of the token value from the query parameter the API returns the first page of the result. | [optional] 
 **placement_option_id** | **String**| The placement option to get transportation options for. Either &#x60;placementOptionId&#x60; or &#x60;shipmentId&#x60; must be specified. | [optional] 
 **shipment_id** | **String**| The shipment to get transportation options for. Either &#x60;placementOptionId&#x60; or &#x60;shipmentId&#x60; must be specified. | [optional] 

### Return type

[**ListTransportationOptionsResponse**](ListTransportationOptionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **schedule_self_ship_appointment**
> ScheduleSelfShipAppointmentResponse schedule_self_ship_appointment(bodyinbound_plan_idshipment_idslot_id)

scheduleSelfShipAppointment

Confirms or reschedules a self-ship appointment slot against a shipment.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::ScheduleSelfShipAppointmentRequest.new # ScheduleSelfShipAppointmentRequest | The body of the request to `scheduleSelfShipAppointment`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.
slot_id = 'slot_id_example' # String | An identifier to a self-ship appointment slot.


begin
  #scheduleSelfShipAppointment
  result = api_instance.schedule_self_ship_appointment(bodyinbound_plan_idshipment_idslot_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->schedule_self_ship_appointment: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ScheduleSelfShipAppointmentRequest**](ScheduleSelfShipAppointmentRequest.md)| The body of the request to &#x60;scheduleSelfShipAppointment&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 
 **slot_id** | **String**| An identifier to a self-ship appointment slot. | 

### Return type

[**ScheduleSelfShipAppointmentResponse**](ScheduleSelfShipAppointmentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **set_packing_information**
> SetPackingInformationResponse set_packing_information(bodyinbound_plan_id)

setPackingInformation

Sets packing information for an inbound plan. This should be called after an inbound plan is created to populate the box level information required for planning and transportation estimates.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::SetPackingInformationRequest.new # SetPackingInformationRequest | The body of the request to `setPackingInformation`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.


begin
  #setPackingInformation
  result = api_instance.set_packing_information(bodyinbound_plan_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->set_packing_information: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**SetPackingInformationRequest**](SetPackingInformationRequest.md)| The body of the request to &#x60;setPackingInformation&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 

### Return type

[**SetPackingInformationResponse**](SetPackingInformationResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **set_prep_details**
> SetPrepDetailsResponse set_prep_details(body)

setPrepDetails

Set the preparation details for a list of MSKUs in a specified marketplace.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::SetPrepDetailsRequest.new # SetPrepDetailsRequest | The body of the request to `setPrepDetails`.


begin
  #setPrepDetails
  result = api_instance.set_prep_details(body)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->set_prep_details: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**SetPrepDetailsRequest**](SetPrepDetailsRequest.md)| The body of the request to &#x60;setPrepDetails&#x60;. | 

### Return type

[**SetPrepDetailsResponse**](SetPrepDetailsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **update_inbound_plan_name**
> update_inbound_plan_name(bodyinbound_plan_id)

updateInboundPlanName

Updates the name of an existing inbound plan.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::UpdateInboundPlanNameRequest.new # UpdateInboundPlanNameRequest | The body of the request to `updateInboundPlanName`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.


begin
  #updateInboundPlanName
  api_instance.update_inbound_plan_name(bodyinbound_plan_id)
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->update_inbound_plan_name: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**UpdateInboundPlanNameRequest**](UpdateInboundPlanNameRequest.md)| The body of the request to &#x60;updateInboundPlanName&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **update_item_compliance_details**
> UpdateItemComplianceDetailsResponse update_item_compliance_details(bodymarketplace_id)

updateItemComplianceDetails

Update compliance details for a list of MSKUs. The details provided here are only used for the India (IN - A21TJRUUN4KGV) marketplace compliance validation.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 6 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::UpdateItemComplianceDetailsRequest.new # UpdateItemComplianceDetailsRequest | The body of the request to `updateItemComplianceDetails`.
marketplace_id = 'marketplace_id_example' # String | The Marketplace ID. For a list of possible values, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids).


begin
  #updateItemComplianceDetails
  result = api_instance.update_item_compliance_details(bodymarketplace_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->update_item_compliance_details: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**UpdateItemComplianceDetailsRequest**](UpdateItemComplianceDetailsRequest.md)| The body of the request to &#x60;updateItemComplianceDetails&#x60;. | 
 **marketplace_id** | **String**| The Marketplace ID. For a list of possible values, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids). | 

### Return type

[**UpdateItemComplianceDetailsResponse**](UpdateItemComplianceDetailsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **update_shipment_name**
> update_shipment_name(bodyinbound_plan_idshipment_id)

updateShipmentName

Updates the name of an existing shipment.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::UpdateShipmentNameRequest.new # UpdateShipmentNameRequest | The body of the request to `updateShipmentName`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.


begin
  #updateShipmentName
  api_instance.update_shipment_name(bodyinbound_plan_idshipment_id)
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->update_shipment_name: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**UpdateShipmentNameRequest**](UpdateShipmentNameRequest.md)| The body of the request to &#x60;updateShipmentName&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **update_shipment_source_address**
> UpdateShipmentSourceAddressResponse update_shipment_source_address(bodyinbound_plan_idshipment_id)

updateShipmentSourceAddress

Updates the source address of an existing shipment. The shipment source address can only be updated prior to the confirmation of the shipment carriers. As a result of the updated source address, existing transportation options will be invalidated and will need to be regenerated to capture the potential difference in transportation options and quotes due to the new source address.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::UpdateShipmentSourceAddressRequest.new # UpdateShipmentSourceAddressRequest | The body of the request to `updateShipmentSourceAddress`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.


begin
  #updateShipmentSourceAddress
  result = api_instance.update_shipment_source_address(bodyinbound_plan_idshipment_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->update_shipment_source_address: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**UpdateShipmentSourceAddressRequest**](UpdateShipmentSourceAddressRequest.md)| The body of the request to &#x60;updateShipmentSourceAddress&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 

### Return type

[**UpdateShipmentSourceAddressResponse**](UpdateShipmentSourceAddressResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **update_shipment_tracking_details**
> UpdateShipmentTrackingDetailsResponse update_shipment_tracking_details(bodyinbound_plan_idshipment_id)

updateShipmentTrackingDetails

Updates a shipment's tracking details.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'fulfillment-inbound-api-model'

api_instance = AmzSpApi::FulfillmentInboundApiModel::FulfillmentInboundApi.new
body = AmzSpApi::FulfillmentInboundApiModel::UpdateShipmentTrackingDetailsRequest.new # UpdateShipmentTrackingDetailsRequest | The body of the request to `updateShipmentTrackingDetails`.
inbound_plan_id = 'inbound_plan_id_example' # String | Identifier of an inbound plan.
shipment_id = 'shipment_id_example' # String | Identifier of a shipment. A shipment contains the boxes and units being inbounded.


begin
  #updateShipmentTrackingDetails
  result = api_instance.update_shipment_tracking_details(bodyinbound_plan_idshipment_id)
  p result
rescue AmzSpApi::FulfillmentInboundApiModel::ApiError => e
  puts "Exception when calling FulfillmentInboundApi->update_shipment_tracking_details: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**UpdateShipmentTrackingDetailsRequest**](UpdateShipmentTrackingDetailsRequest.md)| The body of the request to &#x60;updateShipmentTrackingDetails&#x60;. | 
 **inbound_plan_id** | **String**| Identifier of an inbound plan. | 
 **shipment_id** | **String**| Identifier of a shipment. A shipment contains the boxes and units being inbounded. | 

### Return type

[**UpdateShipmentTrackingDetailsResponse**](UpdateShipmentTrackingDetailsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



