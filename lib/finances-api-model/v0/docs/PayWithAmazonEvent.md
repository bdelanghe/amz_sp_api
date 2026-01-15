# AmzSpApi::FinancesApiModel::V0::PayWithAmazonEvent

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**seller_order_id** | **String** | An order identifier that is specified by the seller. | [optional] 
**transaction_posted_date** | **Date** |  | [optional] 
**business_object_type** | **String** | The type of business object. | [optional] 
**sales_channel** | **String** | The sales channel for the transaction. | [optional] 
**charge** | [**ChargeComponent**](ChargeComponent.md) |  | [optional] 
**fee_list** | [**FeeComponentList**](FeeComponentList.md) |  | [optional] 
**payment_amount_type** | **String** | The type of payment.  Possible values:  * &#x60;Sales&#x60; | [optional] 
**amount_description** | **String** | A short description of this payment event. | [optional] 
**fulfillment_channel** | **String** | The fulfillment channel.  Possible values:  * &#x60;AFN&#x60;: Amazon Fulfillment Network (Fulfillment by Amazon)  * &#x60;MFN&#x60;: Merchant Fulfillment Network (self-fulfilled) | [optional] 
**store_name** | **String** | The name of the store where the event occurred. | [optional] 

