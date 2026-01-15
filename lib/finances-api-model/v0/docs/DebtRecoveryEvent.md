# AmzSpApi::FinancesApiModel::V0::DebtRecoveryEvent

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**debt_recovery_type** | **String** | The debt recovery type.  Possible values:  * &#x60;DebtPayment&#x60; * &#x60;DebtPaymentFailure&#x60; * &#x60;DebtAdjustment&#x60; | [optional] 
**recovery_amount** | [**Currency**](Currency.md) |  | [optional] 
**over_payment_credit** | [**Currency**](Currency.md) |  | [optional] 
**debt_recovery_item_list** | [**DebtRecoveryItemList**](DebtRecoveryItemList.md) |  | [optional] 
**charge_instrument_list** | [**ChargeInstrumentList**](ChargeInstrumentList.md) |  | [optional] 

