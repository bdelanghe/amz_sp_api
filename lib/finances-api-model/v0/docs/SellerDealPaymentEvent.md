# AmzSpApi::FinancesApiModel::V0::SellerDealPaymentEvent

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**posted_date** | **Date** |  | [optional] 
**deal_id** | **String** | The unique identifier of the deal. | [optional] 
**deal_description** | **String** | The internal description of the deal. | [optional] 
**event_type** | **String** | The type of event: &#x60;SellerDealComplete&#x60;. | [optional] 
**fee_type** | **String** | The type of fee: &#x60;RunLightningDealFee&#x60;. | [optional] 
**fee_amount** | [**Currency**](Currency.md) |  | [optional] 
**tax_amount** | [**Currency**](Currency.md) |  | [optional] 
**total_amount** | [**Currency**](Currency.md) |  | [optional] 

