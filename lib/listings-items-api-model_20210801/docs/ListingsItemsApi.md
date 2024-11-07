# AmzSpApi::ListingsItemsApiModel20210801::ListingsItemsApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**delete_listings_item**](ListingsItemsApi.md#delete_listings_item) | **DELETE** /listings/2021-08-01/items/{sellerId}/{sku} | deleteListingsItem
[**get_listings_item**](ListingsItemsApi.md#get_listings_item) | **GET** /listings/2021-08-01/items/{sellerId}/{sku} | getListingsItem
[**patch_listings_item**](ListingsItemsApi.md#patch_listings_item) | **PATCH** /listings/2021-08-01/items/{sellerId}/{sku} | patchListingsItem
[**put_listings_item**](ListingsItemsApi.md#put_listings_item) | **PUT** /listings/2021-08-01/items/{sellerId}/{sku} | putListingsItem
[**search_listings_items**](ListingsItemsApi.md#search_listings_items) | **GET** /listings/2021-08-01/items/{sellerId} | searchListingsItems

# **delete_listings_item**
> ListingsItemSubmissionResponse delete_listings_item(seller_id, sku, marketplace_ids, opts)

deleteListingsItem

Delete a listings item for a selling partner.  **Note:** The parameters associated with this operation may contain special characters that must be encoded to successfully call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 5 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'listings-items-api-model_20210801'

api_instance = AmzSpApi::ListingsItemsApiModel20210801::ListingsItemsApi.new
seller_id = 'seller_id_example' # String | A selling partner identifier, such as a merchant account or vendor code.
sku = 'sku_example' # String | A selling partner provided identifier for an Amazon listing.
marketplace_ids = ['marketplace_ids_example'] # Array<String> | A comma-delimited list of Amazon marketplace identifiers for the request.
opts = { 
  issue_locale: 'issue_locale_example' # String | A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: `en_US`, `fr_CA`, `fr_FR`. Localized messages default to `en_US` when a localization is not available in the specified locale.
}

begin
  #deleteListingsItem
  result = api_instance.delete_listings_item(seller_id, sku, marketplace_ids, opts)
  p result
rescue AmzSpApi::ListingsItemsApiModel20210801::ApiError => e
  puts "Exception when calling ListingsItemsApi->delete_listings_item: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **seller_id** | **String**| A selling partner identifier, such as a merchant account or vendor code. | 
 **sku** | **String**| A selling partner provided identifier for an Amazon listing. | 
 **marketplace_ids** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of Amazon marketplace identifiers for the request. | 
 **issue_locale** | **String**| A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: &#x60;en_US&#x60;, &#x60;fr_CA&#x60;, &#x60;fr_FR&#x60;. Localized messages default to &#x60;en_US&#x60; when a localization is not available in the specified locale. | [optional] 

### Return type

[**ListingsItemSubmissionResponse**](ListingsItemSubmissionResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_listings_item**
> Item get_listings_item(seller_id, sku, marketplace_ids, opts)

getListingsItem

Returns details about a listings item for a selling partner.  **Note:** The parameters associated with this operation may contain special characters that must be encoded to successfully call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 5 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'listings-items-api-model_20210801'

api_instance = AmzSpApi::ListingsItemsApiModel20210801::ListingsItemsApi.new
seller_id = 'seller_id_example' # String | A selling partner identifier, such as a merchant account or vendor code.
sku = 'sku_example' # String | A selling partner provided identifier for an Amazon listing.
marketplace_ids = ['marketplace_ids_example'] # Array<String> | A comma-delimited list of Amazon marketplace identifiers for the request.
opts = { 
  issue_locale: 'issue_locale_example', # String | A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: `en_US`, `fr_CA`, `fr_FR`. Localized messages default to `en_US` when a localization is not available in the specified locale.
  included_data: ['included_data_example'] # Array<String> | A comma-delimited list of data sets to include in the response. Default: `summaries`.
}

begin
  #getListingsItem
  result = api_instance.get_listings_item(seller_id, sku, marketplace_ids, opts)
  p result
rescue AmzSpApi::ListingsItemsApiModel20210801::ApiError => e
  puts "Exception when calling ListingsItemsApi->get_listings_item: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **seller_id** | **String**| A selling partner identifier, such as a merchant account or vendor code. | 
 **sku** | **String**| A selling partner provided identifier for an Amazon listing. | 
 **marketplace_ids** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of Amazon marketplace identifiers for the request. | 
 **issue_locale** | **String**| A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: &#x60;en_US&#x60;, &#x60;fr_CA&#x60;, &#x60;fr_FR&#x60;. Localized messages default to &#x60;en_US&#x60; when a localization is not available in the specified locale. | [optional] 
 **included_data** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of data sets to include in the response. Default: &#x60;summaries&#x60;. | [optional] 

### Return type

[**Item**](Item.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **patch_listings_item**
> ListingsItemSubmissionResponse patch_listings_item(bodymarketplace_idsseller_idsku, opts)

patchListingsItem

Partially update (patch) a listings item for a selling partner. Only top-level listings item attributes can be patched. Patching nested attributes is not supported.  **Note:** This operation has a throttling rate of one request per second when `mode` is `VALIDATION_PREVIEW`.  **Note:** The parameters associated with this operation may contain special characters that must be encoded to successfully call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 5 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'listings-items-api-model_20210801'

api_instance = AmzSpApi::ListingsItemsApiModel20210801::ListingsItemsApi.new
body = AmzSpApi::ListingsItemsApiModel20210801::ListingsItemPatchRequest.new # ListingsItemPatchRequest | The request body schema for the `patchListingsItem` operation.
marketplace_ids = ['marketplace_ids_example'] # Array<String> | A comma-delimited list of Amazon marketplace identifiers for the request.
seller_id = 'seller_id_example' # String | A selling partner identifier, such as a merchant account or vendor code.
sku = 'sku_example' # String | A selling partner provided identifier for an Amazon listing.
opts = { 
  included_data: ['included_data_example'] # Array<String> | A comma-delimited list of data sets to include in the response. Default: `issues`.
  mode: 'mode_example' # String | The mode of operation for the request.
  issue_locale: 'issue_locale_example' # String | A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: `en_US`, `fr_CA`, `fr_FR`. Localized messages default to `en_US` when a localization is not available in the specified locale.
}

begin
  #patchListingsItem
  result = api_instance.patch_listings_item(bodymarketplace_idsseller_idsku, opts)
  p result
rescue AmzSpApi::ListingsItemsApiModel20210801::ApiError => e
  puts "Exception when calling ListingsItemsApi->patch_listings_item: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ListingsItemPatchRequest**](ListingsItemPatchRequest.md)| The request body schema for the &#x60;patchListingsItem&#x60; operation. | 
 **marketplace_ids** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of Amazon marketplace identifiers for the request. | 
 **seller_id** | **String**| A selling partner identifier, such as a merchant account or vendor code. | 
 **sku** | **String**| A selling partner provided identifier for an Amazon listing. | 
 **included_data** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of data sets to include in the response. Default: &#x60;issues&#x60;. | [optional] 
 **mode** | **String**| The mode of operation for the request. | [optional] 
 **issue_locale** | **String**| A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: &#x60;en_US&#x60;, &#x60;fr_CA&#x60;, &#x60;fr_FR&#x60;. Localized messages default to &#x60;en_US&#x60; when a localization is not available in the specified locale. | [optional] 

### Return type

[**ListingsItemSubmissionResponse**](ListingsItemSubmissionResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **put_listings_item**
> ListingsItemSubmissionResponse put_listings_item(bodymarketplace_idsseller_idsku, opts)

putListingsItem

Creates or fully updates an existing listings item for a selling partner.  **Note:** This operation has a throttling rate of one request per second when `mode` is `VALIDATION_PREVIEW`.  **Note:** The parameters associated with this operation may contain special characters that must be encoded to successfully call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 5 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'listings-items-api-model_20210801'

api_instance = AmzSpApi::ListingsItemsApiModel20210801::ListingsItemsApi.new
body = AmzSpApi::ListingsItemsApiModel20210801::ListingsItemPutRequest.new # ListingsItemPutRequest | The request body schema for the `putListingsItem` operation.
marketplace_ids = ['marketplace_ids_example'] # Array<String> | A comma-delimited list of Amazon marketplace identifiers for the request.
seller_id = 'seller_id_example' # String | A selling partner identifier, such as a merchant account or vendor code.
sku = 'sku_example' # String | A selling partner provided identifier for an Amazon listing.
opts = { 
  included_data: ['included_data_example'] # Array<String> | A comma-delimited list of data sets to include in the response. Default: `issues`.
  mode: 'mode_example' # String | The mode of operation for the request.
  issue_locale: 'issue_locale_example' # String | A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: `en_US`, `fr_CA`, `fr_FR`. Localized messages default to `en_US` when a localization is not available in the specified locale.
}

begin
  #putListingsItem
  result = api_instance.put_listings_item(bodymarketplace_idsseller_idsku, opts)
  p result
rescue AmzSpApi::ListingsItemsApiModel20210801::ApiError => e
  puts "Exception when calling ListingsItemsApi->put_listings_item: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ListingsItemPutRequest**](ListingsItemPutRequest.md)| The request body schema for the &#x60;putListingsItem&#x60; operation. | 
 **marketplace_ids** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of Amazon marketplace identifiers for the request. | 
 **seller_id** | **String**| A selling partner identifier, such as a merchant account or vendor code. | 
 **sku** | **String**| A selling partner provided identifier for an Amazon listing. | 
 **included_data** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of data sets to include in the response. Default: &#x60;issues&#x60;. | [optional] 
 **mode** | **String**| The mode of operation for the request. | [optional] 
 **issue_locale** | **String**| A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: &#x60;en_US&#x60;, &#x60;fr_CA&#x60;, &#x60;fr_FR&#x60;. Localized messages default to &#x60;en_US&#x60; when a localization is not available in the specified locale. | [optional] 

### Return type

[**ListingsItemSubmissionResponse**](ListingsItemSubmissionResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **search_listings_items**
> ItemSearchResults search_listings_items(seller_id, marketplace_ids, opts)

searchListingsItems

Search for and return list of listings items and respective details for a selling partner.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 5 | 5 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values then those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'listings-items-api-model_20210801'

api_instance = AmzSpApi::ListingsItemsApiModel20210801::ListingsItemsApi.new
seller_id = 'seller_id_example' # String | A selling partner identifier, such as a merchant account or vendor code.
marketplace_ids = ['marketplace_ids_example'] # Array<String> | A comma-delimited list of Amazon marketplace identifiers for the request.
opts = { 
  identifiers: ['identifiers_example'], # Array<String> | A comma-delimited list of product identifiers to search for listings items by.   **Note**:  1. Required when `identifiersType` is provided.
  identifiers_type: 'identifiers_type_example', # String | Type of product identifiers to search for listings items by.   **Note**:  1. Required when `identifiers` is provided.
  page_size: 10, # Integer | Number of results to be returned per page.
  page_token: 'page_token_example', # String | A token to fetch a certain page when there are multiple pages worth of results.
  included_data: ['included_data_example'], # Array<String> | A comma-delimited list of data sets to include in the response. Default: summaries.
  issue_locale: 'issue_locale_example' # String | A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: \"en_US\", \"fr_CA\", \"fr_FR\". Localized messages default to \"en_US\" when a localization is not available in the specified locale.
}

begin
  #searchListingsItems
  result = api_instance.search_listings_items(seller_id, marketplace_ids, opts)
  p result
rescue AmzSpApi::ListingsItemsApiModel20210801::ApiError => e
  puts "Exception when calling ListingsItemsApi->search_listings_items: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **seller_id** | **String**| A selling partner identifier, such as a merchant account or vendor code. | 
 **marketplace_ids** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of Amazon marketplace identifiers for the request. | 
 **identifiers** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of product identifiers to search for listings items by.   **Note**:  1. Required when &#x60;identifiersType&#x60; is provided. | [optional] 
 **identifiers_type** | **String**| Type of product identifiers to search for listings items by.   **Note**:  1. Required when &#x60;identifiers&#x60; is provided. | [optional] 
 **page_size** | **Integer**| Number of results to be returned per page. | [optional] [default to 10]
 **page_token** | **String**| A token to fetch a certain page when there are multiple pages worth of results. | [optional] 
 **included_data** | [**Array&lt;String&gt;**](String.md)| A comma-delimited list of data sets to include in the response. Default: summaries. | [optional] 
 **issue_locale** | **String**| A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: \&quot;en_US\&quot;, \&quot;fr_CA\&quot;, \&quot;fr_FR\&quot;. Localized messages default to \&quot;en_US\&quot; when a localization is not available in the specified locale. | [optional] 

### Return type

[**ItemSearchResults**](ItemSearchResults.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



