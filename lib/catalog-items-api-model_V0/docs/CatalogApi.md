# AmzSpApi::CatalogItemsApiModelV0::CatalogApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_catalog_item**](CatalogApi.md#get_catalog_item) | **GET** /catalog/v0/items/{asin} | 
[**list_catalog_categories**](CatalogApi.md#list_catalog_categories) | **GET** /catalog/v0/categories | 
[**list_catalog_items**](CatalogApi.md#list_catalog_items) | **GET** /catalog/v0/items | 

# **get_catalog_item**
> GetCatalogItemResponse get_catalog_item(marketplace_id, asin)



Effective September 30, 2022, the `getCatalogItem` operation will no longer be available in the Selling Partner API for Catalog Items v0. This operation is available in the latest version of the [Selling Partner API for Catalog Items v2022-04-01](doc:catalog-items-api-v2022-04-01-reference). Integrations that rely on this operation should migrate to the latest version to avoid service disruption.  _Note:_ The [`listCatalogCategories`](#get-catalogv0categories) operation is not being deprecated and you can continue to make calls to it.

### Example
```ruby
# load the gem
require 'catalog-items-api-model_V0'

api_instance = AmzSpApi::CatalogItemsApiModelV0::CatalogApi.new
marketplace_id = 'marketplace_id_example' # String | A marketplace identifier. Specifies the marketplace for the item.
asin = 'asin_example' # String | The Amazon Standard Identification Number (ASIN) of the item.


begin
  result = api_instance.get_catalog_item(marketplace_id, asin)
  p result
rescue AmzSpApi::CatalogItemsApiModelV0::ApiError => e
  puts "Exception when calling CatalogApi->get_catalog_item: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **marketplace_id** | **String**| A marketplace identifier. Specifies the marketplace for the item. | 
 **asin** | **String**| The Amazon Standard Identification Number (ASIN) of the item. | 

### Return type

[**GetCatalogItemResponse**](GetCatalogItemResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_catalog_categories**
> ListCatalogCategoriesResponse list_catalog_categories(marketplace_id, opts)



Returns the parent categories to which an item belongs, based on the specified ASIN or SellerSKU.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'catalog-items-api-model_V0'

api_instance = AmzSpApi::CatalogItemsApiModelV0::CatalogApi.new
marketplace_id = 'marketplace_id_example' # String | A marketplace identifier. Specifies the marketplace for the item.
opts = { 
  asin: 'asin_example', # String | The Amazon Standard Identification Number (ASIN) of the item.
  seller_sku: 'seller_sku_example' # String | Used to identify items in the given marketplace. SellerSKU is qualified by the seller's SellerId, which is included with every operation that you submit.
}

begin
  result = api_instance.list_catalog_categories(marketplace_id, opts)
  p result
rescue AmzSpApi::CatalogItemsApiModelV0::ApiError => e
  puts "Exception when calling CatalogApi->list_catalog_categories: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **marketplace_id** | **String**| A marketplace identifier. Specifies the marketplace for the item. | 
 **asin** | **String**| The Amazon Standard Identification Number (ASIN) of the item. | [optional] 
 **seller_sku** | **String**| Used to identify items in the given marketplace. SellerSKU is qualified by the seller&#x27;s SellerId, which is included with every operation that you submit. | [optional] 

### Return type

[**ListCatalogCategoriesResponse**](ListCatalogCategoriesResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_catalog_items**
> ListCatalogItemsResponse list_catalog_items(marketplace_id, opts)



Effective September 30, 2022, the `listCatalogItems` operation will no longer be available in the Selling Partner API for Catalog Items v0. As an alternative, `searchCatalogItems` is available in the latest version of the [Selling Partner API for Catalog Items v2022-04-01](doc:catalog-items-api-v2022-04-01-reference). Integrations that rely on the `listCatalogItems` operation should migrate to the `searchCatalogItems`operation to avoid service disruption.  _Note:_ The [`listCatalogCategories`](#get-catalogv0categories) operation is not being deprecated and you can continue to make calls to it.

### Example
```ruby
# load the gem
require 'catalog-items-api-model_V0'

api_instance = AmzSpApi::CatalogItemsApiModelV0::CatalogApi.new
marketplace_id = 'marketplace_id_example' # String | A marketplace identifier. Specifies the marketplace for which items are returned.
opts = { 
  query: 'query_example', # String | Keyword(s) to use to search for items in the catalog. Example: 'harry potter books'.
  query_context_id: 'query_context_id_example', # String | An identifier for the context within which the given search will be performed. A marketplace might provide mechanisms for constraining a search to a subset of potential items. For example, the retail marketplace allows queries to be constrained to a specific category. The QueryContextId parameter specifies such a subset. If it is omitted, the search will be performed using the default context for the marketplace, which will typically contain the largest set of items.
  seller_sku: 'seller_sku_example', # String | Used to identify an item in the given marketplace. SellerSKU is qualified by the seller's SellerId, which is included with every operation that you submit.
  upc: 'upc_example', # String | A 12-digit bar code used for retail packaging.
  ean: 'ean_example', # String | A European article number that uniquely identifies the catalog item, manufacturer, and its attributes.
  isbn: 'isbn_example', # String | The unique commercial book identifier used to identify books internationally.
  jan: 'jan_example' # String | A Japanese article number that uniquely identifies the product, manufacturer, and its attributes.
}

begin
  result = api_instance.list_catalog_items(marketplace_id, opts)
  p result
rescue AmzSpApi::CatalogItemsApiModelV0::ApiError => e
  puts "Exception when calling CatalogApi->list_catalog_items: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **marketplace_id** | **String**| A marketplace identifier. Specifies the marketplace for which items are returned. | 
 **query** | **String**| Keyword(s) to use to search for items in the catalog. Example: &#x27;harry potter books&#x27;. | [optional] 
 **query_context_id** | **String**| An identifier for the context within which the given search will be performed. A marketplace might provide mechanisms for constraining a search to a subset of potential items. For example, the retail marketplace allows queries to be constrained to a specific category. The QueryContextId parameter specifies such a subset. If it is omitted, the search will be performed using the default context for the marketplace, which will typically contain the largest set of items. | [optional] 
 **seller_sku** | **String**| Used to identify an item in the given marketplace. SellerSKU is qualified by the seller&#x27;s SellerId, which is included with every operation that you submit. | [optional] 
 **upc** | **String**| A 12-digit bar code used for retail packaging. | [optional] 
 **ean** | **String**| A European article number that uniquely identifies the catalog item, manufacturer, and its attributes. | [optional] 
 **isbn** | **String**| The unique commercial book identifier used to identify books internationally. | [optional] 
 **jan** | **String**| A Japanese article number that uniquely identifies the product, manufacturer, and its attributes. | [optional] 

### Return type

[**ListCatalogItemsResponse**](ListCatalogItemsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



