# AmzSpApi::ExternalFulfillmentShipments::Shipment

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | The shipment&#x27;s ID. | 
**location_id** | **String** | The location identifier of the seller&#x27;s location in the marketplace channel to which the shipment has been created for fulfillment. | 
**marketplace_attributes** | [**MarketplaceAttributes**](MarketplaceAttributes.md) |  | 
**shipment_info** | [**ShipmentInfo**](ShipmentInfo.md) |  | 
**invoice_info** | [**InvoiceInfo**](InvoiceInfo.md) |  | [optional] 
**party_info_list** | [**PartyIdentificationInfoList**](PartyIdentificationInfoList.md) |  | [optional] 
**shipment_requirements** | [**ShipmentRequirements**](ShipmentRequirements.md) |  | 
**charges** | [**Charges**](Charges.md) |  | 
**status** | **String** | The current status of the shipment. | 
**sub_status** | **String** | The sub status of the shipment. | [optional] 
**reason** | **String** | The reason for the sub-status. | [optional] 
**line_items** | [**Array&lt;ShipmentLineItem&gt;**](ShipmentLineItem.md) | The line items in the shipment. | 
**shipping_info** | [**ShippingInfo**](ShippingInfo.md) |  | 
**packages** | [**Array&lt;Package&gt;**](Package.md) | The list of packages in the shipment. | [optional] 
**creation_date_time** | **DateTime** |  | 
**last_updated_date_time** | **DateTime** |  | 
**earliest_pack_date_time** | **DateTime** |  | [optional] 

