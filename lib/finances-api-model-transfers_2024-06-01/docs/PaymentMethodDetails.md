# AmzSpApi::FinancesApiModelTransfers_20240601::PaymentMethodDetails

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**account_holder_name** | **String** | The name of the account holder who is registered for the payment method. | [optional] 
**payment_method_id** | **String** | The payment method identifier. | [optional] 
**tail** | **String** | The last three or four digits of the payment method. | [optional] 
**expiry_date** | [**ExpiryDate**](ExpiryDate.md) |  | [optional] 
**country_code** | **String** | The two-letter country code in ISO 3166-1 alpha-2 format. For payment methods in the &#x60;card&#x60; category, the code is for the country where the card was issued. For payment methods in the &#x60;bank account&#x60; category, the code is for the country where the account is located. | [optional] 
**payment_method_type** | [**PaymentMethodType**](PaymentMethodType.md) |  | [optional] 
**assignment_type** | [**AssignmentType**](AssignmentType.md) |  | [optional] 

