# AmzSpApi::CatalogItemsApiModelCatalogItems_20220401::ItemSalesRanksByMarketplace

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**marketplace_id** | **String** | Amazon marketplace identifier. To find the ID for your marketplace, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids). | 
**classification_ranks** | [**Array&lt;ItemClassificationSalesRank&gt;**](ItemClassificationSalesRank.md) | Sales ranks of an Amazon catalog item for a &#x60;marketplaceId&#x60;, grouped by classification. | [optional] 
**display_group_ranks** | [**Array&lt;ItemDisplayGroupSalesRank&gt;**](ItemDisplayGroupSalesRank.md) | Sales ranks of an Amazon catalog item for a &#x60;marketplaceId&#x60;, grouped by website display group. | [optional] 

