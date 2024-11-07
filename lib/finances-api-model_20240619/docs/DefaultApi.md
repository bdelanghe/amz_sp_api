# AmzSpApi::FinancesApiModel20240619::DefaultApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**list_transactions**](DefaultApi.md#list_transactions) | **GET** /finances/2024-06-19/transactions | 

# **list_transactions**
> ListTransactionsResponse list_transactions(posted_after, opts)



Returns transactions for the given parameters. Orders from the last 48 hours might not be included in financial events.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.5 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'finances-api-model_20240619'

api_instance = AmzSpApi::FinancesApiModel20240619::DefaultApi.new
posted_after = DateTime.parse('2013-10-20T19:20:30+01:00') # DateTime | The response includes financial events posted after (or on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. The date-time must be more than two minutes before the time of the request.
opts = { 
  posted_before: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | The response includes financial events posted before (but not on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.  The date-time must be later than `PostedAfter` and more than two minutes before the request was submitted. If `PostedAfter` and `PostedBefore` are more than 180 days apart, the response is empty.  **Default:** Two minutes before the time of the request.
  marketplace_id: 'marketplace_id_example', # String | The ID of the marketplace from which you want to retrieve transactions.
  next_token: 'next_token_example' # String | The response includes `nextToken` when the number of results exceeds the specified `pageSize` value. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until `nextToken` is null. Note that this operation can return empty pages.
}

begin
  result = api_instance.list_transactions(posted_after, opts)
  p result
rescue AmzSpApi::FinancesApiModel20240619::ApiError => e
  puts "Exception when calling DefaultApi->list_transactions: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **posted_after** | **DateTime**| The response includes financial events posted after (or on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. The date-time must be more than two minutes before the time of the request. | 
 **posted_before** | **DateTime**| The response includes financial events posted before (but not on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.  The date-time must be later than &#x60;PostedAfter&#x60; and more than two minutes before the request was submitted. If &#x60;PostedAfter&#x60; and &#x60;PostedBefore&#x60; are more than 180 days apart, the response is empty.  **Default:** Two minutes before the time of the request. | [optional] 
 **marketplace_id** | **String**| The ID of the marketplace from which you want to retrieve transactions. | [optional] 
 **next_token** | **String**| The response includes &#x60;nextToken&#x60; when the number of results exceeds the specified &#x60;pageSize&#x60; value. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until &#x60;nextToken&#x60; is null. Note that this operation can return empty pages. | [optional] 

### Return type

[**ListTransactionsResponse**](ListTransactionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



