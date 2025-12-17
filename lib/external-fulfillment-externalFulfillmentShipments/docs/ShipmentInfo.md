# AmzSpApi::ExternalFulfillmentShipments::ShipmentInfo

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**shipment_type** | **String** | The type of shipment. | 
**original_shipment_info** | [**ReplacedShipmentInfo**](ReplacedShipmentInfo.md) |  | [optional] 
**number_of_units** | **Integer** | Total number of units in the shipment. | 
**priority** | [**Priority**](Priority.md) |  | 
**buyer_order_id** | **String** | The buyer&#x27;s order ID. | 
**order_states_eligible_for_rejection** | **Array&lt;String&gt;** | A list of order statuses for which the marketplace allows order rejection (seller cancellation). If the order has a status that does not belong to this list, then seller cancellation is not possible. | [optional] 
**order_placed_timestamp** | **String** | The timestamp of when the order was placed, in UTC | [optional] 
**processing_source** | **String** | The source of the order operation. | [optional] 

