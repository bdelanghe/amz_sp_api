# AmzSpApi::FinancesApiModel::V0::ProductAdsPaymentEvent

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**posted_date** | **Date** |  | [optional] 
**transaction_type** | **String** | Indicates if the transaction is for a charge or a refund.  Possible values:  * &#x60;charge&#x60;  * &#x60;refund&#x60; | [optional] 
**invoice_id** | **String** | The identifier for the invoice that includes the transaction. | [optional] 
**base_value** | [**Currency**](Currency.md) |  | [optional] 
**tax_value** | [**Currency**](Currency.md) |  | [optional] 
**transaction_value** | [**Currency**](Currency.md) |  | [optional] 

