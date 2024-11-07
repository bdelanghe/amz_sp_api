# AmzSpApi::ReportsApiModel20200904::ReportsApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cancel_report**](ReportsApi.md#cancel_report) | **DELETE** /reports/2020-09-04/reports/{reportId} | 
[**cancel_report_schedule**](ReportsApi.md#cancel_report_schedule) | **DELETE** /reports/2020-09-04/schedules/{reportScheduleId} | 
[**create_report**](ReportsApi.md#create_report) | **POST** /reports/2020-09-04/reports | 
[**create_report_schedule**](ReportsApi.md#create_report_schedule) | **POST** /reports/2020-09-04/schedules | 
[**get_report**](ReportsApi.md#get_report) | **GET** /reports/2020-09-04/reports/{reportId} | 
[**get_report_document**](ReportsApi.md#get_report_document) | **GET** /reports/2020-09-04/documents/{reportDocumentId} | 
[**get_report_schedule**](ReportsApi.md#get_report_schedule) | **GET** /reports/2020-09-04/schedules/{reportScheduleId} | 
[**get_report_schedules**](ReportsApi.md#get_report_schedules) | **GET** /reports/2020-09-04/schedules | 
[**get_reports**](ReportsApi.md#get_reports) | **GET** /reports/2020-09-04/reports | 

# **cancel_report**
> CancelReportResponse cancel_report(report_id)



Effective **June 27, 2023**, the `cancelReport` operation will no longer be available in the Selling Partner API for Reports v2020-09-04 and all calls to it will fail. Integrations that rely on this operation should migrate to [Reports v2021-06-30](https://developer-docs.amazon.com/sp-api/docs/reports-api-v2021-06-30-reference) to avoid service disruption.

### Example
```ruby
# load the gem
require 'reports-api-model_20200904'

api_instance = AmzSpApi::ReportsApiModel20200904::ReportsApi.new
report_id = 'report_id_example' # String | The identifier for the report. This identifier is unique only in combination with a seller ID.


begin
  result = api_instance.cancel_report(report_id)
  p result
rescue AmzSpApi::ReportsApiModel20200904::ApiError => e
  puts "Exception when calling ReportsApi->cancel_report: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **report_id** | **String**| The identifier for the report. This identifier is unique only in combination with a seller ID. | 

### Return type

[**CancelReportResponse**](CancelReportResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **cancel_report_schedule**
> CancelReportScheduleResponse cancel_report_schedule(report_schedule_id)



Effective **June 27, 2023**, the `cancelReportSchedule` operation will no longer be available in the Selling Partner API for Reports v2020-09-04 and all calls to it will fail. Integrations that rely on this operation should migrate to [Reports v2021-06-30](https://developer-docs.amazon.com/sp-api/docs/reports-api-v2021-06-30-reference) to avoid service disruption.

### Example
```ruby
# load the gem
require 'reports-api-model_20200904'

api_instance = AmzSpApi::ReportsApiModel20200904::ReportsApi.new
report_schedule_id = 'report_schedule_id_example' # String | The identifier for the report schedule. This identifier is unique only in combination with a seller ID.


begin
  result = api_instance.cancel_report_schedule(report_schedule_id)
  p result
rescue AmzSpApi::ReportsApiModel20200904::ApiError => e
  puts "Exception when calling ReportsApi->cancel_report_schedule: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **report_schedule_id** | **String**| The identifier for the report schedule. This identifier is unique only in combination with a seller ID. | 

### Return type

[**CancelReportScheduleResponse**](CancelReportScheduleResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **create_report**
> CreateReportResponse create_report(body)



Effective **June 27, 2023**, the `createReport` operation will no longer be available in the Selling Partner API for Reports v2020-09-04 and all calls to it will fail. Integrations that rely on this operation should migrate to [Reports v2021-06-30](https://developer-docs.amazon.com/sp-api/docs/reports-api-v2021-06-30-reference) to avoid service disruption.

### Example
```ruby
# load the gem
require 'reports-api-model_20200904'

api_instance = AmzSpApi::ReportsApiModel20200904::ReportsApi.new
body = AmzSpApi::ReportsApiModel20200904::CreateReportSpecification.new # CreateReportSpecification | 


begin
  result = api_instance.create_report(body)
  p result
rescue AmzSpApi::ReportsApiModel20200904::ApiError => e
  puts "Exception when calling ReportsApi->create_report: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CreateReportSpecification**](CreateReportSpecification.md)|  | 

### Return type

[**CreateReportResponse**](CreateReportResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **create_report_schedule**
> CreateReportScheduleResponse create_report_schedule(body)



Effective **June 27, 2023**, the `createReportSchedule` operation will no longer be available in the Selling Partner API for Reports v2020-09-04 and all calls to it will fail. Integrations that rely on this operation should migrate to [Reports v2021-06-30](https://developer-docs.amazon.com/sp-api/docs/reports-api-v2021-06-30-reference) to avoid service disruption.

### Example
```ruby
# load the gem
require 'reports-api-model_20200904'

api_instance = AmzSpApi::ReportsApiModel20200904::ReportsApi.new
body = AmzSpApi::ReportsApiModel20200904::CreateReportScheduleSpecification.new # CreateReportScheduleSpecification | 


begin
  result = api_instance.create_report_schedule(body)
  p result
rescue AmzSpApi::ReportsApiModel20200904::ApiError => e
  puts "Exception when calling ReportsApi->create_report_schedule: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CreateReportScheduleSpecification**](CreateReportScheduleSpecification.md)|  | 

### Return type

[**CreateReportScheduleResponse**](CreateReportScheduleResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_report**
> GetReportResponse get_report(report_id)



Effective **June 27, 2023**, the `getReport` operation will no longer be available in the Selling Partner API for Reports v2020-09-04 and all calls to it will fail. Integrations that rely on this operation should migrate to [Reports v2021-06-30](https://developer-docs.amazon.com/sp-api/docs/reports-api-v2021-06-30-reference) to avoid service disruption.

### Example
```ruby
# load the gem
require 'reports-api-model_20200904'

api_instance = AmzSpApi::ReportsApiModel20200904::ReportsApi.new
report_id = 'report_id_example' # String | The identifier for the report. This identifier is unique only in combination with a seller ID.


begin
  result = api_instance.get_report(report_id)
  p result
rescue AmzSpApi::ReportsApiModel20200904::ApiError => e
  puts "Exception when calling ReportsApi->get_report: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **report_id** | **String**| The identifier for the report. This identifier is unique only in combination with a seller ID. | 

### Return type

[**GetReportResponse**](GetReportResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_report_document**
> GetReportDocumentResponse get_report_document(report_document_id)



Effective **June 27, 2023**, the `getReportDocument` operation will no longer be available in the Selling Partner API for Reports v2020-09-04 and all calls to it will fail. Integrations that rely on this operation should migrate to [Reports v2021-06-30](https://developer-docs.amazon.com/sp-api/docs/reports-api-v2021-06-30-reference) to avoid service disruption.

### Example
```ruby
# load the gem
require 'reports-api-model_20200904'

api_instance = AmzSpApi::ReportsApiModel20200904::ReportsApi.new
report_document_id = 'report_document_id_example' # String | The identifier for the report document.


begin
  result = api_instance.get_report_document(report_document_id)
  p result
rescue AmzSpApi::ReportsApiModel20200904::ApiError => e
  puts "Exception when calling ReportsApi->get_report_document: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **report_document_id** | **String**| The identifier for the report document. | 

### Return type

[**GetReportDocumentResponse**](GetReportDocumentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_report_schedule**
> GetReportScheduleResponse get_report_schedule(report_schedule_id)



Effective **June 27, 2023**, the `getReportSchedule` operation will no longer be available in the Selling Partner API for Reports v2020-09-04 and all calls to it will fail. Integrations that rely on this operation should migrate to [Reports v2021-06-30](https://developer-docs.amazon.com/sp-api/docs/reports-api-v2021-06-30-reference) to avoid service disruption.

### Example
```ruby
# load the gem
require 'reports-api-model_20200904'

api_instance = AmzSpApi::ReportsApiModel20200904::ReportsApi.new
report_schedule_id = 'report_schedule_id_example' # String | The identifier for the report schedule. This identifier is unique only in combination with a seller ID.


begin
  result = api_instance.get_report_schedule(report_schedule_id)
  p result
rescue AmzSpApi::ReportsApiModel20200904::ApiError => e
  puts "Exception when calling ReportsApi->get_report_schedule: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **report_schedule_id** | **String**| The identifier for the report schedule. This identifier is unique only in combination with a seller ID. | 

### Return type

[**GetReportScheduleResponse**](GetReportScheduleResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_report_schedules**
> GetReportSchedulesResponse get_report_schedules(report_types)



Effective **June 27, 2023**, the `getReportSchedules` operation will no longer be available in the Selling Partner API for Reports v2020-09-04 and all calls to it will fail. Integrations that rely on this operation should migrate to [Reports v2021-06-30](https://developer-docs.amazon.com/sp-api/docs/reports-api-v2021-06-30-reference) to avoid service disruption.

### Example
```ruby
# load the gem
require 'reports-api-model_20200904'

api_instance = AmzSpApi::ReportsApiModel20200904::ReportsApi.new
report_types = ['report_types_example'] # Array<String> | A list of report types used to filter report schedules.


begin
  result = api_instance.get_report_schedules(report_types)
  p result
rescue AmzSpApi::ReportsApiModel20200904::ApiError => e
  puts "Exception when calling ReportsApi->get_report_schedules: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **report_types** | [**Array&lt;String&gt;**](String.md)| A list of report types used to filter report schedules. | 

### Return type

[**GetReportSchedulesResponse**](GetReportSchedulesResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_reports**
> GetReportsResponse get_reports(opts)



Effective **June 27, 2023**, the `getReports` operation will no longer be available in the Selling Partner API for Reports v2020-09-04 and all calls to it will fail. Integrations that rely on this operation should migrate to [Reports v2021-06-30](https://developer-docs.amazon.com/sp-api/docs/reports-api-v2021-06-30-reference) to avoid service disruption.

### Example
```ruby
# load the gem
require 'reports-api-model_20200904'

api_instance = AmzSpApi::ReportsApiModel20200904::ReportsApi.new
opts = { 
  report_types: ['report_types_example'], # Array<String> | A list of report types used to filter reports. When reportTypes is provided, the other filter parameters (processingStatuses, marketplaceIds, createdSince, createdUntil) and pageSize may also be provided. Either reportTypes or nextToken is required.
  processing_statuses: ['processing_statuses_example'], # Array<String> | A list of processing statuses used to filter reports.
  marketplace_ids: ['marketplace_ids_example'], # Array<String> | A list of marketplace identifiers used to filter reports. The reports returned will match at least one of the marketplaces that you specify.
  page_size: 10, # Integer | The maximum number of reports to return in a single call.
  created_since: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | The earliest report creation date and time for reports to include in the response, in ISO 8601 date time format. The default is 90 days ago. Reports are retained for a maximum of 90 days.
  created_until: DateTime.parse('2013-10-20T19:20:30+01:00'), # DateTime | The latest report creation date and time for reports to include in the response, in ISO 8601 date time format. The default is now.
  next_token: 'next_token_example' # String | A string token returned in the response to your previous request. nextToken is returned when the number of results exceeds the specified pageSize value. To get the next page of results, call the getReports operation and include this token as the only parameter. Specifying nextToken with any other parameters will cause the request to fail.
}

begin
  result = api_instance.get_reports(opts)
  p result
rescue AmzSpApi::ReportsApiModel20200904::ApiError => e
  puts "Exception when calling ReportsApi->get_reports: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **report_types** | [**Array&lt;String&gt;**](String.md)| A list of report types used to filter reports. When reportTypes is provided, the other filter parameters (processingStatuses, marketplaceIds, createdSince, createdUntil) and pageSize may also be provided. Either reportTypes or nextToken is required. | [optional] 
 **processing_statuses** | [**Array&lt;String&gt;**](String.md)| A list of processing statuses used to filter reports. | [optional] 
 **marketplace_ids** | [**Array&lt;String&gt;**](String.md)| A list of marketplace identifiers used to filter reports. The reports returned will match at least one of the marketplaces that you specify. | [optional] 
 **page_size** | **Integer**| The maximum number of reports to return in a single call. | [optional] [default to 10]
 **created_since** | **DateTime**| The earliest report creation date and time for reports to include in the response, in ISO 8601 date time format. The default is 90 days ago. Reports are retained for a maximum of 90 days. | [optional] 
 **created_until** | **DateTime**| The latest report creation date and time for reports to include in the response, in ISO 8601 date time format. The default is now. | [optional] 
 **next_token** | **String**| A string token returned in the response to your previous request. nextToken is returned when the number of results exceeds the specified pageSize value. To get the next page of results, call the getReports operation and include this token as the only parameter. Specifying nextToken with any other parameters will cause the request to fail. | [optional] 

### Return type

[**GetReportsResponse**](GetReportsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



