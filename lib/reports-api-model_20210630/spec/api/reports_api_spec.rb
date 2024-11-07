=begin
#Report v2021-06-30

#The Selling Partner API for Reports lets you retrieve and manage a variety of reports that can help selling partners manage their businesses.

OpenAPI spec version: 2021-06-30

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'

# Unit tests for AmzSpApi::ReportsApiModel20210630::ReportsApi
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'ReportsApi' do
  before do
    # run before each test
    @instance = AmzSpApi::ReportsApiModel20210630::ReportsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of ReportsApi' do
    it 'should create an instance of ReportsApi' do
      expect(@instance).to be_instance_of(AmzSpApi::ReportsApiModel20210630::ReportsApi)
    end
  end

  # unit tests for cancel_report
  # cancelReport
  # Cancels the report that you specify. Only reports with &#x60;processingStatus&#x3D;IN_QUEUE&#x60; can be cancelled. Cancelled reports are returned in subsequent calls to the &#x60;getReport&#x60; and &#x60;getReports&#x60; operations.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param report_id The identifier for the report. This identifier is unique only in combination with a seller ID.
  # @param [Hash] opts the optional parameters
  # @return [nil]
  describe 'cancel_report test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for cancel_report_schedule
  # cancelReportSchedule
  # Cancels the report schedule that you specify.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param report_schedule_id The identifier for the report schedule. This identifier is unique only in combination with a seller ID.
  # @param [Hash] opts the optional parameters
  # @return [nil]
  describe 'cancel_report_schedule test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for create_report
  # createReport
  # Creates a report.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0167 | 15 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param body Information required to create the report.
  # @param [Hash] opts the optional parameters
  # @return [CreateReportResponse]
  describe 'create_report test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for create_report_schedule
  # createReportSchedule
  # Creates a report schedule. If a report schedule with the same report type and marketplace IDs already exists, it will be cancelled and replaced with this one.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param body Information required to create the report schedule.
  # @param [Hash] opts the optional parameters
  # @return [CreateReportScheduleResponse]
  describe 'create_report_schedule test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for get_report
  # getReport
  # Returns report details (including the &#x60;reportDocumentId&#x60;, if available) for the report that you specify.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 15 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param report_id The identifier for the report. This identifier is unique only in combination with a seller ID.
  # @param [Hash] opts the optional parameters
  # @return [Report]
  describe 'get_report test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for get_report_document
  # getReportDocument
  # Returns the information required for retrieving a report document&#x27;s contents.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0167 | 15 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param report_document_id The identifier for the report document.
  # @param [Hash] opts the optional parameters
  # @return [ReportDocument]
  describe 'get_report_document test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for get_report_schedule
  # getReportSchedule
  # Returns report schedule details for the report schedule that you specify.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param report_schedule_id The identifier for the report schedule. This identifier is unique only in combination with a seller ID.
  # @param [Hash] opts the optional parameters
  # @return [ReportSchedule]
  describe 'get_report_schedule test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for get_report_schedules
  # getReportSchedules
  # Returns report schedule details that match the filters that you specify.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param report_types A list of report types used to filter report schedules. Refer to [Report Type Values](https://developer-docs.amazon.com/sp-api/docs/report-type-values) for more information.
  # @param [Hash] opts the optional parameters
  # @return [ReportScheduleList]
  describe 'get_report_schedules test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for get_reports
  # getReports
  # Returns report details for the reports that match the filters that you specify.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param [Hash] opts the optional parameters
  # @option opts [Array<String>] :report_types A list of report types used to filter reports. Refer to [Report Type Values](https://developer-docs.amazon.com/sp-api/docs/report-type-values) for more information. When reportTypes is provided, the other filter parameters (processingStatuses, marketplaceIds, createdSince, createdUntil) and pageSize may also be provided. Either reportTypes or nextToken is required.
  # @option opts [Array<String>] :processing_statuses A list of processing statuses used to filter reports.
  # @option opts [Array<String>] :marketplace_ids A list of marketplace identifiers used to filter reports. The reports returned will match at least one of the marketplaces that you specify.
  # @option opts [Integer] :page_size The maximum number of reports to return in a single call.
  # @option opts [DateTime] :created_since The earliest report creation date and time for reports to include in the response, in &lt;a href&#x3D;&#x27;https://developer-docs.amazon.com/sp-api/docs/iso-8601&#x27;&gt;ISO 8601&lt;/a&gt; date time format. The default is 90 days ago. Reports are retained for a maximum of 90 days.
  # @option opts [DateTime] :created_until The latest report creation date and time for reports to include in the response, in &lt;a href&#x3D;&#x27;https://developer-docs.amazon.com/sp-api/docs/iso-8601&#x27;&gt;ISO 8601&lt;/a&gt; date time format. The default is now.
  # @option opts [String] :next_token A string token returned in the response to your previous request. &#x60;nextToken&#x60; is returned when the number of results exceeds the specified &#x60;pageSize&#x60; value. To get the next page of results, call the &#x60;getReports&#x60; operation and include this token as the only parameter. Specifying &#x60;nextToken&#x60; with any other parameters will cause the request to fail.
  # @return [GetReportsResponse]
  describe 'get_reports test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
