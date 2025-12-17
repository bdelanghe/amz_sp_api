# AmzSpApi::ExternalFulfillmentShipments::ShipmentLineItem

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**shipment_line_item_id** | **String** | An identifier for a shipment&#x27;s line item. This identifier is guaranteed to be unique within the scope of its containing shipment. | 
**merchant_sku** | [**SKU**](SKU.md) |  | 
**number_of_units** | **Integer** | The number of items of the SKU in this line item. | 
**serial_numbers** | [**Array&lt;SerialNumber&gt;**](SerialNumber.md) | The serial numbers for each item in this line item. | [optional] 
**piece_type** | [**PieceType**](PieceType.md) |  | [optional] 
**hazmat_labels** | **Array&lt;String&gt;** | A list of HAZMAT label identifiers that must be applied to the packages for this line item. | [optional] 
**gift_attributes** | [**GiftAttributes**](GiftAttributes.md) |  | [optional] 
**charges** | [**Charges**](Charges.md) |  | 
**cancellations** | [**Cancellations**](Cancellations.md) |  | [optional] 
**hsn_code** | **String** | The HSN code of SKU in this line item. | [optional] 
**recommended_country_of_origin** | [**CountryCode**](CountryCode.md) |  | [optional] 
**country_of_origin** | [**CountryCode**](CountryCode.md) |  | [optional] 
**recommended_currency_code** | **String** | The three digit currency code of the currency recommended by the marketplace, in ISO 4217 format. | [optional] 
**item_value** | [**Amount**](Amount.md) |  | [optional] 
**compliance_attributes** | [**ComplianceAttributes**](ComplianceAttributes.md) |  | 
**custom_attributes** | [**Array&lt;CustomAttribute&gt;**](CustomAttribute.md) | A list of custom passthrough attributes. For details on these attributes, reach out to your respective program teams at Amazon. | [optional] 

