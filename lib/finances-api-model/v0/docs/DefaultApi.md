# AmzSpApi::FinancesApiModel::V0::DefaultApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**list_financial_event_groups**](DefaultApi.md#list_financial_event_groups) | **GET** /finances/v0/financialEventGroups | 
[**list_financial_events**](DefaultApi.md#list_financial_events) | **GET** /finances/v0/financialEvents | 
[**list_financial_events_by_group_id**](DefaultApi.md#list_financial_events_by_group_id) | **GET** /finances/v0/financialEventGroups/{eventGroupId}/financialEvents | 
[**list_financial_events_by_order_id**](DefaultApi.md#list_financial_events_by_order_id) | **GET** /finances/v0/orders/{orderId}/financialEvents | 

# **list_financial_event_groups**
> ListFinancialEventGroupsResponse list_financial_event_groups(opts)



Returns financial event groups for a given date range. Orders from the last 48 hours might not be included in financial events.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.5 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput can have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'finances-api-model'

api_instance = AmzSpApi::FinancesApiModel::V0::DefaultApi.new
opts = { 
  max_results_per_page: 10, # Integer | The maximum number of results per page. If the response exceeds the maximum number of transactions or 10 MB, the response is `InvalidInput`.
  financial_event_group_started_before: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | A date that selects financial event groups that opened before (but not at) a specified date and time, in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) format. The date-time must be after `FinancialEventGroupStartedAfter` and more than two minutes before the time of request. If `FinancialEventGroupStartedAfter` and `FinancialEventGroupStartedBefore` are more than 180 days apart, no financial event groups are returned.
  financial_event_group_started_after: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | A date that selects financial event groups that opened after (or at) a specified date and time, in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) format. The date-time must be more than two minutes before you submit the request.
  next_token: 'next_token_example' # String | The response includes `nextToken` when the number of results exceeds the specified `pageSize` value. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until `nextToken` is null. Note that this operation can return empty pages.
}

begin
  result = api_instance.list_financial_event_groups(opts)
  p result
rescue AmzSpApi::FinancesApiModel::V0::ApiError => e
  puts "Exception when calling DefaultApi->list_financial_event_groups: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **max_results_per_page** | **Integer**| The maximum number of results per page. If the response exceeds the maximum number of transactions or 10 MB, the response is &#x60;InvalidInput&#x60;. | [optional] [default to 10]
 **financial_event_group_started_before** | **DateTime**| A date that selects financial event groups that opened before (but not at) a specified date and time, in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) format. The date-time must be after &#x60;FinancialEventGroupStartedAfter&#x60; and more than two minutes before the time of request. If &#x60;FinancialEventGroupStartedAfter&#x60; and &#x60;FinancialEventGroupStartedBefore&#x60; are more than 180 days apart, no financial event groups are returned. | [optional] 
 **financial_event_group_started_after** | **DateTime**| A date that selects financial event groups that opened after (or at) a specified date and time, in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) format. The date-time must be more than two minutes before you submit the request. | [optional] 
 **next_token** | **String**| The response includes &#x60;nextToken&#x60; when the number of results exceeds the specified &#x60;pageSize&#x60; value. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until &#x60;nextToken&#x60; is null. Note that this operation can return empty pages. | [optional] 

### Return type

[**ListFinancialEventGroupsResponse**](ListFinancialEventGroupsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_financial_events**
> ListFinancialEventsResponse list_financial_events(opts)



Returns financial events for the specified data range. Orders from the last 48 hours might not be included in financial events.  **Note:** in `ListFinancialEvents`, deferred events don't show up in responses until they are released.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.5 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput can have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'finances-api-model'

api_instance = AmzSpApi::FinancesApiModel::V0::DefaultApi.new
opts = { 
  max_results_per_page: 100, # Integer | The maximum number of results to return per page. If the response exceeds the maximum number of transactions or 10 MB, the response is `InvalidInput`.
  posted_after: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | The response includes financial events posted after (or on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. The date-time must be more than two minutes before the time of the request.
  posted_before: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | The response includes financial events posted before (but not on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.  The date-time must be later than `PostedAfter` and more than two minutes before the request was submitted. If `PostedAfter` and `PostedBefore` are more than 180 days apart, the response is empty. If you include the `PostedBefore` parameter in your request, you must also specify the `PostedAfter` parameter.  **Default:** Two minutes before the time of the request.
  next_token: 'next_token_example' # String | The response includes `nextToken` when the number of results exceeds the specified `pageSize` value. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until `nextToken` is null. Note that this operation can return empty pages.
}

begin
  result = api_instance.list_financial_events(opts)
  p result
rescue AmzSpApi::FinancesApiModel::V0::ApiError => e
  puts "Exception when calling DefaultApi->list_financial_events: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **max_results_per_page** | **Integer**| The maximum number of results to return per page. If the response exceeds the maximum number of transactions or 10 MB, the response is &#x60;InvalidInput&#x60;. | [optional] [default to 100]
 **posted_after** | **DateTime**| The response includes financial events posted after (or on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. The date-time must be more than two minutes before the time of the request. | [optional] 
 **posted_before** | **DateTime**| The response includes financial events posted before (but not on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.  The date-time must be later than &#x60;PostedAfter&#x60; and more than two minutes before the request was submitted. If &#x60;PostedAfter&#x60; and &#x60;PostedBefore&#x60; are more than 180 days apart, the response is empty. If you include the &#x60;PostedBefore&#x60; parameter in your request, you must also specify the &#x60;PostedAfter&#x60; parameter.  **Default:** Two minutes before the time of the request. | [optional] 
 **next_token** | **String**| The response includes &#x60;nextToken&#x60; when the number of results exceeds the specified &#x60;pageSize&#x60; value. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until &#x60;nextToken&#x60; is null. Note that this operation can return empty pages. | [optional] 

### Return type

[**ListFinancialEventsResponse**](ListFinancialEventsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_financial_events_by_group_id**
> ListFinancialEventsResponse list_financial_events_by_group_id(event_group_id, opts)



Returns all financial events for the specified financial event group. Orders from the last 48 hours might not be included in financial events.  **Note:** This operation only retrieves a group's data for the past two years. A request for data spanning more than two years produces an empty response.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.5 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput can have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'finances-api-model'

api_instance = AmzSpApi::FinancesApiModel::V0::DefaultApi.new
event_group_id = 'event_group_id_example' # String | The identifier of the financial event group to which the events belong.
opts = { 
  max_results_per_page: 100, # Integer | The maximum number of results to return per page. If the response exceeds the maximum number of transactions or 10 MB, the response is `InvalidInput`.
  posted_after: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | The response includes financial events posted after (or on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. The date-time must be more than two minutes before the time of the request.
  posted_before: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | The response includes financial events posted before (but not on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.  The date-time must be later than `PostedAfter` and more than two minutes before the request was submitted. If `PostedAfter` and `PostedBefore` are more than 180 days apart, the response is empty. If you include the `PostedBefore` parameter in your request, you must also specify the `PostedAfter` parameter.  **Default:** Two minutes before the time of the request.
  next_token: 'next_token_example' # String | The response includes `nextToken` when the number of results exceeds the specified `pageSize` value. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until `nextToken` is null. Note that this operation can return empty pages.
}

begin
  result = api_instance.list_financial_events_by_group_id(event_group_id, opts)
  p result
rescue AmzSpApi::FinancesApiModel::V0::ApiError => e
  puts "Exception when calling DefaultApi->list_financial_events_by_group_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **event_group_id** | **String**| The identifier of the financial event group to which the events belong. | 
 **max_results_per_page** | **Integer**| The maximum number of results to return per page. If the response exceeds the maximum number of transactions or 10 MB, the response is &#x60;InvalidInput&#x60;. | [optional] [default to 100]
 **posted_after** | **DateTime**| The response includes financial events posted after (or on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format. The date-time must be more than two minutes before the time of the request. | [optional] 
 **posted_before** | **DateTime**| The response includes financial events posted before (but not on) this date. This date must be in [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date-time format.  The date-time must be later than &#x60;PostedAfter&#x60; and more than two minutes before the request was submitted. If &#x60;PostedAfter&#x60; and &#x60;PostedBefore&#x60; are more than 180 days apart, the response is empty. If you include the &#x60;PostedBefore&#x60; parameter in your request, you must also specify the &#x60;PostedAfter&#x60; parameter.  **Default:** Two minutes before the time of the request. | [optional] 
 **next_token** | **String**| The response includes &#x60;nextToken&#x60; when the number of results exceeds the specified &#x60;pageSize&#x60; value. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until &#x60;nextToken&#x60; is null. Note that this operation can return empty pages. | [optional] 

### Return type

[**ListFinancialEventsResponse**](ListFinancialEventsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_financial_events_by_order_id**
> ListFinancialEventsResponse list_financial_events_by_order_id(order_id, opts)



Returns all financial events for the specified order. Orders from the last 48 hours might not be included in financial events.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.5 | 30 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput can have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits).

### Example
```ruby
# load the gem
require 'finances-api-model'

api_instance = AmzSpApi::FinancesApiModel::V0::DefaultApi.new
order_id = 'order_id_example' # String | An Amazon-defined order identifier, in 3-7-7 format.
opts = { 
  max_results_per_page: 100, # Integer | The maximum number of results to return per page. If the response exceeds the maximum number of transactions or 10 MB, the response is `InvalidInput`.
  next_token: 'next_token_example' # String | The response includes `nextToken` when the number of results exceeds the specified `pageSize` value. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until `nextToken` is null. Note that this operation can return empty pages.
}

begin
  result = api_instance.list_financial_events_by_order_id(order_id, opts)
  p result
rescue AmzSpApi::FinancesApiModel::V0::ApiError => e
  puts "Exception when calling DefaultApi->list_financial_events_by_order_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **order_id** | **String**| An Amazon-defined order identifier, in 3-7-7 format. | 
 **max_results_per_page** | **Integer**| The maximum number of results to return per page. If the response exceeds the maximum number of transactions or 10 MB, the response is &#x60;InvalidInput&#x60;. | [optional] [default to 100]
 **next_token** | **String**| The response includes &#x60;nextToken&#x60; when the number of results exceeds the specified &#x60;pageSize&#x60; value. To get the next page of results, call the operation with this token and include the same arguments as the call that produced the token. To get a complete list, call this operation until &#x60;nextToken&#x60; is null. Note that this operation can return empty pages. | [optional] 

### Return type

[**ListFinancialEventsResponse**](ListFinancialEventsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



