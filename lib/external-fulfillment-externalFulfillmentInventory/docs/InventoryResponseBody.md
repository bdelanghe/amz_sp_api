# AmzSpApi::ExternalFulfillmentInventory::InventoryResponseBody

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**client_sequence_number** | **Integer** | Latest sequence number for an inventory update. | [optional] 
**location_id** | **String** | The location where inventory is updated or retrieved. | [optional] 
**sku_id** | **String** | The SKU ID for which inventory is updated or retrieved | [optional] 
**sellable_quantity** | **Integer** | The number of items of the specified SKU that are available for purchase. | [optional] 
**reserved_quantity** | **Integer** | The number of items of the specified SKU created in any marketplace that are reserved for shipment and yet to be fulfilled. | [optional] 
**marketplace_attributes** | [**MarketplaceAttributes**](MarketplaceAttributes.md) |  | [optional] 
**actionable_errors** | [**Array&lt;ActionableError&gt;**](ActionableError.md) | Inventory operation errors that require seller action before retrying the inventory request. | [optional] 

