# AmzSpApi::ExternalFulfillment::Package

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | An ID that uniquely identifies a package within a shipment. | 
**dimensions** | [**PackageDimensions**](PackageDimensions.md) |  | 
**weight** | [**Weight**](Weight.md) |  | 
**hazmat_labels** | **Array&lt;String&gt;** | The optional list of HAZMAT labels applied to the package. | [optional] 
**package_line_items** | [**PackageLineItems**](PackageLineItems.md) |  | 
**status** | **String** | The current status of the package. | [optional] 
**package_handling_requirements** | **String** | Whether the package requires standard handling or extra care. | [optional] 

