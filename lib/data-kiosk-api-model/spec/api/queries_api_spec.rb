=begin
#Selling Partner API for Data Kiosk

#The Selling Partner API for Data Kiosk lets you submit GraphQL queries from a variety of schemas to help selling partners manage their businesses.

OpenAPI spec version: 2023-11-15

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'

# Unit tests for AmzSpApi::DataKioskApiModel::QueriesApi
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'QueriesApi' do
  before do
    # run before each test
    @instance = AmzSpApi::DataKioskApiModel::QueriesApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of QueriesApi' do
    it 'should create an instance of QueriesApi' do
      expect(@instance).to be_instance_of(AmzSpApi::DataKioskApiModel::QueriesApi)
    end
  end

  # unit tests for cancel_query
  # Cancels the query specified by the &#x60;queryId&#x60; parameter. Only queries with a non-terminal &#x60;processingStatus&#x60; (&#x60;IN_QUEUE&#x60;, &#x60;IN_PROGRESS&#x60;) can be cancelled. Cancelling a query that already has a &#x60;processingStatus&#x60; of &#x60;CANCELLED&#x60; will no-op. Cancelled queries are returned in subsequent calls to the &#x60;getQuery&#x60; and &#x60;getQueries&#x60; operations.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param query_id The identifier for the query. This identifier is unique only in combination with a selling partner account ID.
  # @param [Hash] opts the optional parameters
  # @return [nil]
  describe 'cancel_query test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for create_query
  # Creates a Data Kiosk query request.  **Note:** The retention of a query varies based on the fields requested. Each field within a schema is annotated with a &#x60;@resultRetention&#x60; directive that defines how long a query containing that field will be retained. When a query contains multiple fields with different retentions, the shortest (minimum) retention is applied. The retention of a query&#x27;s resulting documents always matches the retention of the query.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0167 | 15 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param body The body of the request.
  # @param [Hash] opts the optional parameters
  # @return [CreateQueryResponse]
  describe 'create_query test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for get_document
  # Returns the information required for retrieving a Data Kiosk document&#x27;s contents. See the &#x60;createQuery&#x60; operation for details about document retention.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0167 | 15 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param document_id The identifier for the Data Kiosk document.
  # @param [Hash] opts the optional parameters
  # @return [GetDocumentResponse]
  describe 'get_document test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for get_queries
  # Returns details for the Data Kiosk queries that match the specified filters. See the &#x60;createQuery&#x60; operation for details about query retention.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param [Hash] opts the optional parameters
  # @option opts [Array<String>] :processing_statuses A list of processing statuses used to filter queries.
  # @option opts [Integer] :page_size The maximum number of queries to return in a single call.
  # @option opts [DateTime] :created_since The earliest query creation date and time for queries to include in the response, in ISO 8601 date time format. The default is 90 days ago.
  # @option opts [DateTime] :created_until The latest query creation date and time for queries to include in the response, in ISO 8601 date time format. The default is the time of the &#x60;getQueries&#x60; request.
  # @option opts [String] :pagination_token A token to fetch a certain page of results when there are multiple pages of results available. The value of this token is fetched from the &#x60;pagination.nextToken&#x60; field returned in the &#x60;GetQueriesResponse&#x60; object. All other parameters must be provided with the same values that were provided with the request that generated this token, with the exception of &#x60;pageSize&#x60; which can be modified between calls to &#x60;getQueries&#x60;. In the absence of this token value, &#x60;getQueries&#x60; returns the first page of results.
  # @return [GetQueriesResponse]
  describe 'get_queries test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for get_query
  # Returns query details for the query specified by the &#x60;queryId&#x60; parameter. See the &#x60;createQuery&#x60; operation for details about query retention.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2.0 | 15 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
  # @param query_id The query identifier.
  # @param [Hash] opts the optional parameters
  # @return [Query]
  describe 'get_query test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
