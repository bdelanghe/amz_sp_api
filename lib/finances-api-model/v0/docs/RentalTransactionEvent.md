# AmzSpApi::FinancesApiModel::V0::RentalTransactionEvent

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**amazon_order_id** | **String** | An Amazon-defined identifier for an order. | [optional] 
**rental_event_type** | **String** | The type of rental event.  Possible values:  * &#x60;RentalCustomerPayment-Buyout&#x60;: A transaction type that represents when the customer wants to buy out a rented item.  * &#x60;RentalCustomerPayment-Extension&#x60;: A transaction type that represents when the customer wants to extend the rental period.  * &#x60;RentalCustomerRefund-Buyout&#x60;: A transaction type that represents when the customer requests a refund for the buyout of the rented item.  * &#x60;RentalCustomerRefund-Extension&#x60;: A transaction type that represents when the customer requests a refund over the extension on the rented item.  * &#x60;RentalHandlingFee&#x60;: A transaction type that represents the fee that Amazon charges sellers who rent through Amazon.  * &#x60;RentalChargeFailureReimbursement&#x60;: A transaction type that represents when Amazon sends money to the seller to compensate for a failed charge.  * &#x60;RentalLostItemReimbursement&#x60;: A transaction type that represents when Amazon sends money to the seller to compensate for a lost item. | [optional] 
**extension_length** | **Integer** | The number of days that the buyer extended an already rented item. This value is only returned for &#x60;RentalCustomerPayment-Extension&#x60; and &#x60;RentalCustomerRefund-Extension&#x60; events. | [optional] 
**posted_date** | **Date** |  | [optional] 
**rental_charge_list** | [**ChargeComponentList**](ChargeComponentList.md) |  | [optional] 
**rental_fee_list** | [**FeeComponentList**](FeeComponentList.md) |  | [optional] 
**marketplace_name** | **String** | The name of the marketplace. | [optional] 
**rental_initial_value** | [**Currency**](Currency.md) |  | [optional] 
**rental_reimbursement** | [**Currency**](Currency.md) |  | [optional] 
**rental_tax_withheld_list** | [**TaxWithheldComponentList**](TaxWithheldComponentList.md) |  | [optional] 

