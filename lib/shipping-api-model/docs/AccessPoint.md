# AmzSpApi::ShippingApiModel::AccessPoint

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**access_point_id** | [**AccessPointId**](AccessPointId.md) |  | [optional] 
**name** | **String** | Name of entity (store/hub etc) where this access point is located | [optional] 
**timezone** | **String** | Timezone of access point | [optional] 
**type** | [**AccessPointType**](AccessPointType.md) |  | [optional] 
**accessibility_attributes** | [**AccessibilityAttributes**](AccessibilityAttributes.md) |  | [optional] 
**address** | [**Address**](Address.md) |  | [optional] 
**exception_operating_hours** | [**Array&lt;ExceptionOperatingHours&gt;**](ExceptionOperatingHours.md) |  | [optional] 
**assistance_type** | **String** |  | [optional] 
**score** | **String** | The score of access point, based on proximity to postal code and sorting preference. This can be used to sort access point results on shipper&#x27;s end. | [optional] 
**standard_operating_hours** | [**DayOfWeekTimeMap**](DayOfWeekTimeMap.md) |  | [optional] 

