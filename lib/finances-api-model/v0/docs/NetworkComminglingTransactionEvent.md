# AmzSpApi::FinancesApiModel::V0::NetworkComminglingTransactionEvent

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**transaction_type** | **String** | The type of network item swap.  Possible values:  * &#x60;NetCo&#x60;: A Fulfillment by Amazon inventory pooling transaction. Available only in the India marketplace.  * &#x60;ComminglingVAT&#x60;: A commingling VAT transaction. Available only in the Spain, UK, France, Germany, and Italy marketplaces. | [optional] 
**posted_date** | **Date** |  | [optional] 
**net_co_transaction_id** | **String** | The identifier for the network item swap. | [optional] 
**swap_reason** | **String** | The reason for the network item swap. | [optional] 
**asin** | **String** | The Amazon Standard Identification Number (ASIN) of the swapped item. | [optional] 
**marketplace_id** | **String** | The marketplace in which the event took place. | [optional] 
**tax_exclusive_amount** | [**Currency**](Currency.md) |  | [optional] 
**tax_amount** | [**Currency**](Currency.md) |  | [optional] 

