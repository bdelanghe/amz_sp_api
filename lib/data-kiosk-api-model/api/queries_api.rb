=begin
#Selling Partner API for Data Kiosk

#The Selling Partner API for Data Kiosk lets you submit GraphQL queries from a variety of schemas to help selling partners manage their businesses.

OpenAPI spec version: 2023-11-15

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

module AmzSpApi::DataKioskApiModel
  class QueriesApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Cancels the query specified by the `queryId` parameter. Only queries with a non-terminal `processingStatus` (`IN_QUEUE`, `IN_PROGRESS`) can be cancelled. Cancelling a query that already has a `processingStatus` of `CANCELLED` will no-op. Cancelled queries are returned in subsequent calls to the `getQuery` and `getQueries` operations.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param query_id The identifier for the query. This identifier is unique only in combination with a selling partner account ID.
    # @param [Hash] opts the optional parameters
    # @return [nil]
    def cancel_query(query_id, opts = {})
      cancel_query_with_http_info(query_id, opts)
      nil
    end

    # Cancels the query specified by the &#x60;queryId&#x60; parameter. Only queries with a non-terminal &#x60;processingStatus&#x60; (&#x60;IN_QUEUE&#x60;, &#x60;IN_PROGRESS&#x60;) can be cancelled. Cancelling a query that already has a &#x60;processingStatus&#x60; of &#x60;CANCELLED&#x60; will no-op. Cancelled queries are returned in subsequent calls to the &#x60;getQuery&#x60; and &#x60;getQueries&#x60; operations.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param query_id The identifier for the query. This identifier is unique only in combination with a selling partner account ID.
    # @param [Hash] opts the optional parameters
    # @return [Array<(nil, Integer, Hash)>] nil, response status code and response headers
    def cancel_query_with_http_info(query_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: QueriesApi.cancel_query ...'
      end
      # verify the required parameter 'query_id' is set
      if @api_client.config.client_side_validation && query_id.nil?
        fail ArgumentError, "Missing the required parameter 'query_id' when calling QueriesApi.cancel_query"
      end
      # resource path
      local_var_path = '/dataKiosk/2023-11-15/queries/{queryId}'.sub('{' + 'queryId' + '}', query_id.to_s)

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      return_type = opts[:return_type] 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:DELETE, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: QueriesApi#cancel_query\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Creates a Data Kiosk query request.  **Note:** The retention of a query varies based on the fields requested. Each field within a schema is annotated with a `@resultRetention` directive that defines how long a query containing that field will be retained. When a query contains multiple fields with different retentions, the shortest (minimum) retention is applied. The retention of a query's resulting documents always matches the retention of the query.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0167 | 15 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param body 
    # @param [Hash] opts the optional parameters
    # @return [CreateQueryResponse]
    def create_query(body, opts = {})
      data, _status_code, _headers = create_query_with_http_info(body, opts)
      data
    end

    # Creates a Data Kiosk query request.  **Note:** The retention of a query varies based on the fields requested. Each field within a schema is annotated with a &#x60;@resultRetention&#x60; directive that defines how long a query containing that field will be retained. When a query contains multiple fields with different retentions, the shortest (minimum) retention is applied. The retention of a query&#x27;s resulting documents always matches the retention of the query.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0167 | 15 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param body 
    # @param [Hash] opts the optional parameters
    # @return [Array<(CreateQueryResponse, Integer, Hash)>] CreateQueryResponse data, response status code and response headers
    def create_query_with_http_info(body, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: QueriesApi.create_query ...'
      end
      # verify the required parameter 'body' is set
      if @api_client.config.client_side_validation && body.nil?
        fail ArgumentError, "Missing the required parameter 'body' when calling QueriesApi.create_query"
      end
      # resource path
      local_var_path = '/dataKiosk/2023-11-15/queries'

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] || @api_client.object_to_http_body(body) 

      return_type = opts[:return_type] || 'CreateQueryResponse' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: QueriesApi#create_query\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Returns the information required for retrieving a Data Kiosk document's contents. See the `createQuery` operation for details about document retention.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0167 | 15 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param document_id The identifier for the Data Kiosk document.
    # @param [Hash] opts the optional parameters
    # @return [GetDocumentResponse]
    def get_document(document_id, opts = {})
      data, _status_code, _headers = get_document_with_http_info(document_id, opts)
      data
    end

    # Returns the information required for retrieving a Data Kiosk document&#x27;s contents. See the &#x60;createQuery&#x60; operation for details about document retention.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0167 | 15 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param document_id The identifier for the Data Kiosk document.
    # @param [Hash] opts the optional parameters
    # @return [Array<(GetDocumentResponse, Integer, Hash)>] GetDocumentResponse data, response status code and response headers
    def get_document_with_http_info(document_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: QueriesApi.get_document ...'
      end
      # verify the required parameter 'document_id' is set
      if @api_client.config.client_side_validation && document_id.nil?
        fail ArgumentError, "Missing the required parameter 'document_id' when calling QueriesApi.get_document"
      end
      # resource path
      local_var_path = '/dataKiosk/2023-11-15/documents/{documentId}'.sub('{' + 'documentId' + '}', document_id.to_s)

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      return_type = opts[:return_type] || 'GetDocumentResponse' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: QueriesApi#get_document\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Returns details for the Data Kiosk queries that match the specified filters. See the `createQuery` operation for details about query retention.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param [Hash] opts the optional parameters
    # @option opts [Array<String>] :processing_statuses A list of processing statuses used to filter queries.
    # @option opts [Integer] :page_size The maximum number of queries to return in a single call. (default to 10)
    # @option opts [DateTime] :created_since The earliest query creation date and time for queries to include in the response, in ISO 8601 date time format. The default is 90 days ago.
    # @option opts [DateTime] :created_until The latest query creation date and time for queries to include in the response, in ISO 8601 date time format. The default is the time of the &#x60;getQueries&#x60; request.
    # @option opts [String] :pagination_token A token to fetch a certain page of results when there are multiple pages of results available. The value of this token is fetched from the &#x60;pagination.nextToken&#x60; field returned in the &#x60;GetQueriesResponse&#x60; object. All other parameters must be provided with the same values that were provided with the request that generated this token, with the exception of &#x60;pageSize&#x60; which can be modified between calls to &#x60;getQueries&#x60;. In the absence of this token value, &#x60;getQueries&#x60; returns the first page of results.
    # @return [GetQueriesResponse]
    def get_queries(opts = {})
      data, _status_code, _headers = get_queries_with_http_info(opts)
      data
    end

    # Returns details for the Data Kiosk queries that match the specified filters. See the &#x60;createQuery&#x60; operation for details about query retention.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.0222 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param [Hash] opts the optional parameters
    # @option opts [Array<String>] :processing_statuses A list of processing statuses used to filter queries.
    # @option opts [Integer] :page_size The maximum number of queries to return in a single call.
    # @option opts [DateTime] :created_since The earliest query creation date and time for queries to include in the response, in ISO 8601 date time format. The default is 90 days ago.
    # @option opts [DateTime] :created_until The latest query creation date and time for queries to include in the response, in ISO 8601 date time format. The default is the time of the &#x60;getQueries&#x60; request.
    # @option opts [String] :pagination_token A token to fetch a certain page of results when there are multiple pages of results available. The value of this token is fetched from the &#x60;pagination.nextToken&#x60; field returned in the &#x60;GetQueriesResponse&#x60; object. All other parameters must be provided with the same values that were provided with the request that generated this token, with the exception of &#x60;pageSize&#x60; which can be modified between calls to &#x60;getQueries&#x60;. In the absence of this token value, &#x60;getQueries&#x60; returns the first page of results.
    # @return [Array<(GetQueriesResponse, Integer, Hash)>] GetQueriesResponse data, response status code and response headers
    def get_queries_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: QueriesApi.get_queries ...'
      end
      if @api_client.config.client_side_validation && opts[:'processing_statuses'] && !opts[:'processing_statuses'].all? { |item| ['CANCELLED', 'DONE', 'FATAL', 'IN_PROGRESS', 'IN_QUEUE'].include?(item) }
        fail ArgumentError, 'invalid value for "processing_statuses", must include one of CANCELLED, DONE, FATAL, IN_PROGRESS, IN_QUEUE'
      end
      # resource path
      local_var_path = '/dataKiosk/2023-11-15/queries'

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'processingStatuses'] = @api_client.build_collection_param(opts[:'processing_statuses'], :csv) if !opts[:'processing_statuses'].nil?
      query_params[:'pageSize'] = opts[:'page_size'] if !opts[:'page_size'].nil?
      query_params[:'createdSince'] = opts[:'created_since'] if !opts[:'created_since'].nil?
      query_params[:'createdUntil'] = opts[:'created_until'] if !opts[:'created_until'].nil?
      query_params[:'paginationToken'] = opts[:'pagination_token'] if !opts[:'pagination_token'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      return_type = opts[:return_type] || 'GetQueriesResponse' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: QueriesApi#get_queries\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Returns query details for the query specified by the `queryId` parameter. See the `createQuery` operation for details about query retention.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2.0 | 15 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param query_id The query identifier.
    # @param [Hash] opts the optional parameters
    # @return [Query]
    def get_query(query_id, opts = {})
      data, _status_code, _headers = get_query_with_http_info(query_id, opts)
      data
    end

    # Returns query details for the query specified by the &#x60;queryId&#x60; parameter. See the &#x60;createQuery&#x60; operation for details about query retention.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2.0 | 15 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param query_id The query identifier.
    # @param [Hash] opts the optional parameters
    # @return [Array<(Query, Integer, Hash)>] Query data, response status code and response headers
    def get_query_with_http_info(query_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: QueriesApi.get_query ...'
      end
      # verify the required parameter 'query_id' is set
      if @api_client.config.client_side_validation && query_id.nil?
        fail ArgumentError, "Missing the required parameter 'query_id' when calling QueriesApi.get_query"
      end
      # resource path
      local_var_path = '/dataKiosk/2023-11-15/queries/{queryId}'.sub('{' + 'queryId' + '}', query_id.to_s)

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      return_type = opts[:return_type] || 'Query' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: QueriesApi#get_query\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
