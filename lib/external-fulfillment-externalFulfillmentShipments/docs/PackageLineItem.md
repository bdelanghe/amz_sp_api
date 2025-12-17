# AmzSpApi::ExternalFulfillmentShipments::PackageLineItem

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**package_line_item_id** | **String** | The line item ID. | 
**quantity** | **Integer** | The number of items of a particular line item of a shipment that are packed into the package. | 
**serial_numbers** | [**Array&lt;SerialNumber&gt;**](SerialNumber.md) | The list of serial numbers of items in the package, if required to be provided. | [optional] 
**pieces** | **Integer** | The number of pieces of a multi-piece item that are in this package. This is applicable only for items that are shipped in multiple pieces. | [optional] 
**country_of_origin** | [**CountryCode**](CountryCode.md) |  | [optional] 
**item_value** | [**Amount**](Amount.md) |  | [optional] 

