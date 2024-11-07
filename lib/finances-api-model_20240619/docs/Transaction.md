# AmzSpApi::FinancesApiModel20240619::Transaction

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**selling_partner_metadata** | [**SellingPartnerMetadata**](SellingPartnerMetadata.md) |  | [optional] 
**related_identifiers** | [**RelatedIdentifiers**](RelatedIdentifiers.md) |  | [optional] 
**transaction_type** | **String** | The type of transaction.  **Possible value:** &#x60;Shipment&#x60; | [optional] 
**transaction_id** | **String** | The unique identifier of the transaction. | [optional] 
**transaction_status** | **String** | The status of the transaction.   **Possible values:**  * &#x60;Deferred&#x60; * &#x60;Released&#x60; | [optional] 
**description** | **String** | Describes the reasons for the transaction.  **Example:** &#x27;Order Payment&#x27;, &#x27;Refund Order&#x27; | [optional] 
**posted_date** | **Date** |  | [optional] 
**total_amount** | [**Currency**](Currency.md) |  | [optional] 
**marketplace_details** | [**MarketplaceDetails**](MarketplaceDetails.md) |  | [optional] 
**items** | [**Items**](Items.md) |  | [optional] 
**contexts** | [**Contexts**](Contexts.md) |  | [optional] 
**breakdowns** | [**Breakdowns**](Breakdowns.md) |  | [optional] 

