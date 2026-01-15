# AmzSpApi::FinancesApiModel::V0::AdjustmentEvent

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**adjustment_type** | **String** | The type of adjustment.  Possible values:  * &#x60;FBAInventoryReimbursement&#x60;: An FBA inventory reimbursement to a seller&#x27;s account. This occurs if a seller&#x27;s inventory is damaged. * &#x60;ReserveEvent&#x60;: A reserve event that is generated at the time a settlement period closes. This occurs when some money from a seller&#x27;s account is held back. * &#x60;PostageBilling&#x60;: The amount paid by a seller for shipping labels. * &#x60;PostageRefund&#x60;: The reimbursement of shipping labels purchased for orders that were canceled or refunded. * &#x60;LostOrDamagedReimbursement&#x60;: An Amazon Easy Ship reimbursement to a seller&#x27;s account for a package that we lost or damaged. * &#x60;CanceledButPickedUpReimbursement&#x60;: An Amazon Easy Ship reimbursement to a seller&#x27;s account. This occurs when a package is picked up and the order is subsequently canceled. This value is used only in the India marketplace. * &#x60;ReimbursementClawback&#x60;: An Amazon Easy Ship reimbursement clawback from a seller&#x27;s account. This occurs when a prior reimbursement is reversed. This value is used only in the India marketplace. * &#x60;SellerRewards&#x60;: An award credited to a seller&#x27;s account for their participation in an offer in the Seller Rewards program. Applies only to the India marketplace. | [optional] 
**posted_date** | **Date** |  | [optional] 
**store_name** | **String** | The name of the store where the event occurred. | [optional] 
**adjustment_amount** | [**Currency**](Currency.md) |  | [optional] 
**adjustment_item_list** | [**AdjustmentItemList**](AdjustmentItemList.md) |  | [optional] 

