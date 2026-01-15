# AmzSpApi::CatalogItemsApiModel::2022_04_01::CatalogApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_catalog_item**](CatalogApi.md#get_catalog_item) | **GET** /catalog/2022-04-01/items/{asin} | 
[**search_catalog_items**](CatalogApi.md#search_catalog_items) | **GET** /catalog/2022-04-01/items | 

# **get_catalog_item**
> Item get_catalog_item(asin, marketplace_ids, opts)



Retrieves details for an item in the Amazon catalog.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header contains the usage plan rate limits for the operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput might have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'catalog-items-api-model'

api_instance = AmzSpApi::CatalogItemsApiModel::2022_04_01::CatalogApi.new
asin = 'asin_example' # String | The Amazon Standard Identification Number (ASIN) of the item.
marketplace_ids = ['marketplace_ids_example'] # Array<String> | A comma-delimited list of Amazon marketplace identifiers. To find the ID for your marketplace, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids).
opts = { 
  included_data: ['included_data_example'], # Array<String> | A comma-delimited list of datasets to include in the response.
  locale: 'locale_example' # String | The locale for which you want to retrieve localized summaries. Defaults to the primary locale of the marketplace.
}

begin
  result = api_instance.get_catalog_item(asin, marketplace_ids, opts)
  p result
rescue AmzSpApi::CatalogItemsApiModel::2022_04_01::ApiError => e
  puts "Exception when calling CatalogApi->get_catalog_item: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **asin** | **String**| The Amazon Standard Identification Number (ASIN) of the item. | 
 **marketplace_ids** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of Amazon marketplace identifiers. To find the ID for your marketplace, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids). | 
 **included_data** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of datasets to include in the response. | [optional] 
 **locale** | **String**| The locale for which you want to retrieve localized summaries. Defaults to the primary locale of the marketplace. | [optional] 

### Return type

[**Item**](Item.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **search_catalog_items**
> ItemSearchResults search_catalog_items(marketplace_ids, opts)



Search for a list of Amazon catalog items and item-related information. You can search by identifier or by keywords.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header contains the usage plan rate limits for the operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput might have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'catalog-items-api-model'

api_instance = AmzSpApi::CatalogItemsApiModel::2022_04_01::CatalogApi.new
marketplace_ids = ['marketplace_ids_example'] # Array<String> | A comma-delimited list of Amazon marketplace identifiers. To find the ID for your marketplace, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids).
opts = { 
  identifiers: ['identifiers_example'], # Array<String> | A comma-delimited list of product identifiers that you can use to search the Amazon catalog. **Note:** You cannot include `identifiers` and `keywords` in the same request.
  identifiers_type: 'identifiers_type_example', # String | The type of product identifiers that you can use to search the Amazon catalog. **Note:** `identifiersType` is required when `identifiers` is in the request.
  included_data: ['included_data_example'], # Array<String> | A comma-delimited list of datasets to include in the response.
  locale: 'locale_example', # String | The locale for which you want to retrieve localized summaries. Defaults to the primary locale of the marketplace.
  seller_id: 'seller_id_example', # String | A selling partner identifier, such as a seller account or vendor code. **Note:** Required when `identifiersType` is `SKU`.
  keywords: ['keywords_example'], # Array<String> | A comma-delimited list of keywords that you can use to search the Amazon catalog. **Note:** You cannot include `keywords` and `identifiers` in the same request.
  brand_names: ['brand_names_example'], # Array<String> | A comma-delimited list of brand names that you can use to limit the search in queries based on `keywords`. **Note:** Cannot be used with `identifiers`.
  classification_ids: ['classification_ids_example'], # Array<String> | A comma-delimited list of classification identifiers that you can use to limit the search in queries based on `keywords`. **Note:** Cannot be used with `identifiers`.
  page_size: 10, # Integer | The number of results to include on each page.
  page_token: 'page_token_example', # String | A token that you can use to fetch a specific page when there are multiple pages of results.
  keywords_locale: 'keywords_locale_example' # String | The language of the keywords that are included in queries based on `keywords`. Defaults to the primary locale of the marketplace. **Note:** Cannot be used with `identifiers`.
}

begin
  result = api_instance.search_catalog_items(marketplace_ids, opts)
  p result
rescue AmzSpApi::CatalogItemsApiModel::2022_04_01::ApiError => e
  puts "Exception when calling CatalogApi->search_catalog_items: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **marketplace_ids** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of Amazon marketplace identifiers. To find the ID for your marketplace, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids). | 
 **identifiers** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of product identifiers that you can use to search the Amazon catalog. **Note:** You cannot include &#x60;identifiers&#x60; and &#x60;keywords&#x60; in the same request. | [optional] 
 **identifiers_type** | **String**| The type of product identifiers that you can use to search the Amazon catalog. **Note:** &#x60;identifiersType&#x60; is required when &#x60;identifiers&#x60; is in the request. | [optional] 
 **included_data** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of datasets to include in the response. | [optional] 
 **locale** | **String**| The locale for which you want to retrieve localized summaries. Defaults to the primary locale of the marketplace. | [optional] 
 **seller_id** | **String**| A selling partner identifier, such as a seller account or vendor code. **Note:** Required when &#x60;identifiersType&#x60; is &#x60;SKU&#x60;. | [optional] 
 **keywords** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of keywords that you can use to search the Amazon catalog. **Note:** You cannot include &#x60;keywords&#x60; and &#x60;identifiers&#x60; in the same request. | [optional] 
 **brand_names** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of brand names that you can use to limit the search in queries based on &#x60;keywords&#x60;. **Note:** Cannot be used with &#x60;identifiers&#x60;. | [optional] 
 **classification_ids** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of classification identifiers that you can use to limit the search in queries based on &#x60;keywords&#x60;. **Note:** Cannot be used with &#x60;identifiers&#x60;. | [optional] 
 **page_size** | **Integer**| The number of results to include on each page. | [optional] [default to 10]
 **page_token** | **String**| A token that you can use to fetch a specific page when there are multiple pages of results. | [optional] 
 **keywords_locale** | **String**| The language of the keywords that are included in queries based on &#x60;keywords&#x60;. Defaults to the primary locale of the marketplace. **Note:** Cannot be used with &#x60;identifiers&#x60;. | [optional] 

### Return type

[**ItemSearchResults**](ItemSearchResults.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



