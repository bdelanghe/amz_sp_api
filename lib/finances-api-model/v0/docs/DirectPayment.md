# AmzSpApi::FinancesApiModel::V0::DirectPayment

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**direct_payment_type** | **String** | The type of payment.  Possible values:  * &#x60;StoredValueCardRevenue&#x60; - The amount that is deducted from the seller&#x27;s account because the seller received money through a stored value card.  * &#x60;StoredValueCardRefund&#x60; - The amount that Amazon returns to the seller if the order that is purchased using a stored value card is refunded.  * &#x60;PrivateLabelCreditCardRevenue&#x60; - The amount that is deducted from the seller&#x27;s account because the seller received money through a private label credit card offered by Amazon.  * &#x60;PrivateLabelCreditCardRefund&#x60; - The amount that Amazon returns to the seller if the order that is purchased using a private label credit card offered by Amazon is refunded.  * &#x60;CollectOnDeliveryRevenue&#x60; - The COD amount that the seller collected directly from the buyer.  * &#x60;CollectOnDeliveryRefund&#x60; - The amount that Amazon refunds to the buyer if an order paid for by COD is refunded. | [optional] 
**direct_payment_amount** | [**Currency**](Currency.md) |  | [optional] 

