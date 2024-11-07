=begin
#Selling Partner API for Listings Items

#The Selling Partner API for Listings Items (Listings Items API) provides programmatic access to selling partner listings on Amazon. Use this API in collaboration with the Selling Partner API for Product Type Definitions, which you use to retrieve the information about Amazon product types needed to use the Listings Items API.  For more information, see the [Listing Items API Use Case Guide](doc:listings-items-api-v2020-09-01-use-case-guide).

OpenAPI spec version: 2020-09-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

module AmzSpApi::ListingsItemsApiModel20200901
  class ListingsApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Delete a listings item for a selling partner.  **Note:** The parameters associated with this operation may contain special characters that must be encoded to successfully call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 5 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param seller_id A selling partner identifier, such as a merchant account or vendor code.
    # @param sku A selling partner provided identifier for an Amazon listing.
    # @param marketplace_ids A comma-delimited list of Amazon marketplace identifiers for the request.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :issue_locale A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: \&quot;en_US\&quot;, \&quot;fr_CA\&quot;, \&quot;fr_FR\&quot;. Localized messages default to \&quot;en_US\&quot; when a localization is not available in the specified locale.
    # @return [ListingsItemSubmissionResponse]
    def delete_listings_item(seller_id, sku, marketplace_ids, opts = {})
      data, _status_code, _headers = delete_listings_item_with_http_info(seller_id, sku, marketplace_ids, opts)
      data
    end

    # Delete a listings item for a selling partner.  **Note:** The parameters associated with this operation may contain special characters that must be encoded to successfully call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 5 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param seller_id A selling partner identifier, such as a merchant account or vendor code.
    # @param sku A selling partner provided identifier for an Amazon listing.
    # @param marketplace_ids A comma-delimited list of Amazon marketplace identifiers for the request.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :issue_locale A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: \&quot;en_US\&quot;, \&quot;fr_CA\&quot;, \&quot;fr_FR\&quot;. Localized messages default to \&quot;en_US\&quot; when a localization is not available in the specified locale.
    # @return [Array<(ListingsItemSubmissionResponse, Integer, Hash)>] ListingsItemSubmissionResponse data, response status code and response headers
    def delete_listings_item_with_http_info(seller_id, sku, marketplace_ids, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ListingsApi.delete_listings_item ...'
      end
      # verify the required parameter 'seller_id' is set
      if @api_client.config.client_side_validation && seller_id.nil?
        fail ArgumentError, "Missing the required parameter 'seller_id' when calling ListingsApi.delete_listings_item"
      end
      # verify the required parameter 'sku' is set
      if @api_client.config.client_side_validation && sku.nil?
        fail ArgumentError, "Missing the required parameter 'sku' when calling ListingsApi.delete_listings_item"
      end
      # verify the required parameter 'marketplace_ids' is set
      if @api_client.config.client_side_validation && marketplace_ids.nil?
        fail ArgumentError, "Missing the required parameter 'marketplace_ids' when calling ListingsApi.delete_listings_item"
      end
      # resource path
      local_var_path = '/listings/2020-09-01/items/{sellerId}/{sku}'.sub('{' + 'sellerId' + '}', seller_id.to_s).sub('{' + 'sku' + '}', sku.to_s)

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'marketplaceIds'] = @api_client.build_collection_param(marketplace_ids, :csv)
      query_params[:'issueLocale'] = opts[:'issue_locale'] if !opts[:'issue_locale'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      return_type = opts[:return_type] || 'ListingsItemSubmissionResponse' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:DELETE, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ListingsApi#delete_listings_item\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Partially update (patch) a listings item for a selling partner. Only top-level listings item attributes can be patched. Patching nested attributes is not supported.  **Note:** The parameters associated with this operation may contain special characters that must be encoded to successfully call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 5 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param body The request body schema for the patchListingsItem operation.
    # @param marketplace_ids A comma-delimited list of Amazon marketplace identifiers for the request.
    # @param seller_id A selling partner identifier, such as a merchant account or vendor code.
    # @param sku A selling partner provided identifier for an Amazon listing.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :issue_locale A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: \&quot;en_US\&quot;, \&quot;fr_CA\&quot;, \&quot;fr_FR\&quot;. Localized messages default to \&quot;en_US\&quot; when a localization is not available in the specified locale.
    # @return [ListingsItemSubmissionResponse]
    def patch_listings_item(body, marketplace_ids, seller_id, sku, opts = {})
      data, _status_code, _headers = patch_listings_item_with_http_info(body, marketplace_ids, seller_id, sku, opts)
      data
    end

    # Partially update (patch) a listings item for a selling partner. Only top-level listings item attributes can be patched. Patching nested attributes is not supported.  **Note:** The parameters associated with this operation may contain special characters that must be encoded to successfully call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 5 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param body The request body schema for the patchListingsItem operation.
    # @param marketplace_ids A comma-delimited list of Amazon marketplace identifiers for the request.
    # @param seller_id A selling partner identifier, such as a merchant account or vendor code.
    # @param sku A selling partner provided identifier for an Amazon listing.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :issue_locale A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: \&quot;en_US\&quot;, \&quot;fr_CA\&quot;, \&quot;fr_FR\&quot;. Localized messages default to \&quot;en_US\&quot; when a localization is not available in the specified locale.
    # @return [Array<(ListingsItemSubmissionResponse, Integer, Hash)>] ListingsItemSubmissionResponse data, response status code and response headers
    def patch_listings_item_with_http_info(body, marketplace_ids, seller_id, sku, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ListingsApi.patch_listings_item ...'
      end
      # verify the required parameter 'body' is set
      if @api_client.config.client_side_validation && body.nil?
        fail ArgumentError, "Missing the required parameter 'body' when calling ListingsApi.patch_listings_item"
      end
      # verify the required parameter 'marketplace_ids' is set
      if @api_client.config.client_side_validation && marketplace_ids.nil?
        fail ArgumentError, "Missing the required parameter 'marketplace_ids' when calling ListingsApi.patch_listings_item"
      end
      # verify the required parameter 'seller_id' is set
      if @api_client.config.client_side_validation && seller_id.nil?
        fail ArgumentError, "Missing the required parameter 'seller_id' when calling ListingsApi.patch_listings_item"
      end
      # verify the required parameter 'sku' is set
      if @api_client.config.client_side_validation && sku.nil?
        fail ArgumentError, "Missing the required parameter 'sku' when calling ListingsApi.patch_listings_item"
      end
      # resource path
      local_var_path = '/listings/2020-09-01/items/{sellerId}/{sku}'.sub('{' + 'sellerId' + '}', seller_id.to_s).sub('{' + 'sku' + '}', sku.to_s)

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'marketplaceIds'] = @api_client.build_collection_param(marketplace_ids, :csv)
      query_params[:'issueLocale'] = opts[:'issue_locale'] if !opts[:'issue_locale'].nil?

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

      return_type = opts[:return_type] || 'ListingsItemSubmissionResponse' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:PATCH, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ListingsApi#patch_listings_item\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Creates a new or fully-updates an existing listings item for a selling partner.  **Note:** The parameters associated with this operation may contain special characters that must be encoded to successfully call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 5 | 10 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param body The request body schema for the putListingsItem operation.
    # @param marketplace_ids A comma-delimited list of Amazon marketplace identifiers for the request.
    # @param seller_id A selling partner identifier, such as a merchant account or vendor code.
    # @param sku A selling partner provided identifier for an Amazon listing.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :issue_locale A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: \&quot;en_US\&quot;, \&quot;fr_CA\&quot;, \&quot;fr_FR\&quot;. Localized messages default to \&quot;en_US\&quot; when a localization is not available in the specified locale.
    # @return [ListingsItemSubmissionResponse]
    def put_listings_item(body, marketplace_ids, seller_id, sku, opts = {})
      data, _status_code, _headers = put_listings_item_with_http_info(body, marketplace_ids, seller_id, sku, opts)
      data
    end

    # Creates a new or fully-updates an existing listings item for a selling partner.  **Note:** The parameters associated with this operation may contain special characters that must be encoded to successfully call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 5 | 10 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param body The request body schema for the putListingsItem operation.
    # @param marketplace_ids A comma-delimited list of Amazon marketplace identifiers for the request.
    # @param seller_id A selling partner identifier, such as a merchant account or vendor code.
    # @param sku A selling partner provided identifier for an Amazon listing.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :issue_locale A locale for localization of issues. When not provided, the default language code of the first marketplace is used. Examples: \&quot;en_US\&quot;, \&quot;fr_CA\&quot;, \&quot;fr_FR\&quot;. Localized messages default to \&quot;en_US\&quot; when a localization is not available in the specified locale.
    # @return [Array<(ListingsItemSubmissionResponse, Integer, Hash)>] ListingsItemSubmissionResponse data, response status code and response headers
    def put_listings_item_with_http_info(body, marketplace_ids, seller_id, sku, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ListingsApi.put_listings_item ...'
      end
      # verify the required parameter 'body' is set
      if @api_client.config.client_side_validation && body.nil?
        fail ArgumentError, "Missing the required parameter 'body' when calling ListingsApi.put_listings_item"
      end
      # verify the required parameter 'marketplace_ids' is set
      if @api_client.config.client_side_validation && marketplace_ids.nil?
        fail ArgumentError, "Missing the required parameter 'marketplace_ids' when calling ListingsApi.put_listings_item"
      end
      # verify the required parameter 'seller_id' is set
      if @api_client.config.client_side_validation && seller_id.nil?
        fail ArgumentError, "Missing the required parameter 'seller_id' when calling ListingsApi.put_listings_item"
      end
      # verify the required parameter 'sku' is set
      if @api_client.config.client_side_validation && sku.nil?
        fail ArgumentError, "Missing the required parameter 'sku' when calling ListingsApi.put_listings_item"
      end
      # resource path
      local_var_path = '/listings/2020-09-01/items/{sellerId}/{sku}'.sub('{' + 'sellerId' + '}', seller_id.to_s).sub('{' + 'sku' + '}', sku.to_s)

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'marketplaceIds'] = @api_client.build_collection_param(marketplace_ids, :csv)
      query_params[:'issueLocale'] = opts[:'issue_locale'] if !opts[:'issue_locale'].nil?

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

      return_type = opts[:return_type] || 'ListingsItemSubmissionResponse' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:PUT, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ListingsApi#put_listings_item\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
