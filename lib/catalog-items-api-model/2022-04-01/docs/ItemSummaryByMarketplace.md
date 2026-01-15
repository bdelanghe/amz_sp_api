# AmzSpApi::CatalogItemsApiModel::2022_04_01::ItemSummaryByMarketplace

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**marketplace_id** | **String** | Amazon marketplace identifier. To find the ID for your marketplace, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids). | 
**adult_product** | **BOOLEAN** | When &#x60;true&#x60;, the Amazon catalog item is intended for an adult audience or is sexual in nature. | [optional] 
**autographed** | **BOOLEAN** | When &#x60;true&#x60;, the Amazon catalog item is autographed. | [optional] 
**brand** | **String** | Name of the brand that is associated with the Amazon catalog item. | [optional] 
**browse_classification** | [**ItemBrowseClassification**](ItemBrowseClassification.md) |  | [optional] 
**color** | **String** | The color that is associated with the Amazon catalog item. | [optional] 
**contributors** | [**Array&lt;ItemContributor&gt;**](ItemContributor.md) | Individual contributors to the creation of the item, such as the authors or actors. | [optional] 
**item_classification** | **String** | Classification type that is associated with the Amazon catalog item. | [optional] 
**item_name** | **String** | The name that is associated with the Amazon catalog item. | [optional] 
**manufacturer** | **String** | The name of the manufacturer that is associated with the Amazon catalog item. | [optional] 
**memorabilia** | **BOOLEAN** | When true, the item is classified as memorabilia. | [optional] 
**model_number** | **String** | The model number that is associated with the Amazon catalog item. | [optional] 
**package_quantity** | **Integer** | The quantity of the Amazon catalog item within one package. | [optional] 
**part_number** | **String** | The part number that is associated with the Amazon catalog item. | [optional] 
**release_date** | **Date** | The earliest date on which the Amazon catalog item can be shipped to customers. | [optional] 
**size** | **String** | The name of the size of the Amazon catalog item. | [optional] 
**style** | **String** | The name of the style that is associated with the Amazon catalog item. | [optional] 
**trade_in_eligible** | **BOOLEAN** | When true, the Amazon catalog item is eligible for trade-in. | [optional] 
**website_display_group** | **String** | The identifier of the website display group that is associated with the Amazon catalog item. | [optional] 
**website_display_group_name** | **String** | The display name of the website display group that is associated with the Amazon catalog item. | [optional] 

