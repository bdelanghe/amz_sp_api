# AmzSpApi::FinancesApiModel::V0::AffordabilityExpenseEvent

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**amazon_order_id** | **String** | An Amazon-defined identifier for an order. | [optional] 
**posted_date** | **Date** |  | [optional] 
**marketplace_id** | **String** | The Amazon-defined marketplace identifier. | [optional] 
**transaction_type** | **String** | The type of transaction.   Possible values:  * &#x60;Charge&#x60;: an affordability promotion expense. * &#x60;Refund&#x60;: an affordability promotion expense reversal. | [optional] 
**base_expense** | [**Currency**](Currency.md) |  | [optional] 
**tax_type_cgst** | [**Currency**](Currency.md) |  | 
**tax_type_sgst** | [**Currency**](Currency.md) |  | 
**tax_type_igst** | [**Currency**](Currency.md) |  | 
**total_expense** | [**Currency**](Currency.md) |  | [optional] 

