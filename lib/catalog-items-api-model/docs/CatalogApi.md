# AmzSpApi::CatalogItemsApiModel::CatalogApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**list_catalog_categories**](CatalogApi.md#list_catalog_categories) | **GET** /catalog/v0/categories | 

# **list_catalog_categories**
> ListCatalogCategoriesResponse list_catalog_categories(marketplace_id, opts)



Returns the parent categories to which an item belongs, based on the specified ASIN or SellerSKU.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'catalog-items-api-model'

api_instance = AmzSpApi::CatalogItemsApiModel::CatalogApi.new
marketplace_id = 'marketplace_id_example' # String | A marketplace identifier. Specifies the marketplace for the item.
opts = { 
  asin: 'asin_example', # String | The Amazon Standard Identification Number (ASIN) of the item.
  seller_sku: 'seller_sku_example' # String | Used to identify items in the given marketplace. SellerSKU is qualified by the seller's SellerId, which is included with every operation that you submit.
}

begin
  result = api_instance.list_catalog_categories(marketplace_id, opts)
  p result
rescue AmzSpApi::CatalogItemsApiModel::ApiError => e
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



