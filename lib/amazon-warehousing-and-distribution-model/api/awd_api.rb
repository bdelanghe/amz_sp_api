=begin
#The Selling Partner API for Amazon Warehousing and Distribution

#The Selling Partner API for Amazon Warehousing and Distribution (AWD) provides programmatic access to information about AWD shipments and inventory. 

OpenAPI spec version: 2024-05-09

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

module AmzSpApi::AmazonWarehousingAndDistributionModel
  class AwdApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Retrieves an AWD inbound shipment.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api)
    # @param shipment_id ID for the shipment. A shipment contains the cases being inbounded.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :sku_quantities If equal to &#x60;SHOW&#x60;, the response includes the shipment SKU quantity details.  Defaults to &#x60;HIDE&#x60;, in which case the response does not contain SKU quantities
    # @return [InboundShipment]
    def get_inbound_shipment(shipment_id, opts = {})
      data, _status_code, _headers = get_inbound_shipment_with_http_info(shipment_id, opts)
      data
    end

    # Retrieves an AWD inbound shipment.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api)
    # @param shipment_id ID for the shipment. A shipment contains the cases being inbounded.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :sku_quantities If equal to &#x60;SHOW&#x60;, the response includes the shipment SKU quantity details.  Defaults to &#x60;HIDE&#x60;, in which case the response does not contain SKU quantities
    # @return [Array<(InboundShipment, Integer, Hash)>] InboundShipment data, response status code and response headers
    def get_inbound_shipment_with_http_info(shipment_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AwdApi.get_inbound_shipment ...'
      end
      # verify the required parameter 'shipment_id' is set
      if @api_client.config.client_side_validation && shipment_id.nil?
        fail ArgumentError, "Missing the required parameter 'shipment_id' when calling AwdApi.get_inbound_shipment"
      end
      if @api_client.config.client_side_validation && opts[:'sku_quantities'] && !['SHOW', 'HIDE'].include?(opts[:'sku_quantities'])
        fail ArgumentError, 'invalid value for "sku_quantities", must be one of SHOW, HIDE'
      end
      # resource path
      local_var_path = '/awd/2024-05-09/inboundShipments/{shipmentId}'.sub('{' + 'shipmentId' + '}', shipment_id.to_s)

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'skuQuantities'] = opts[:'sku_quantities'] if !opts[:'sku_quantities'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      return_type = opts[:return_type] || 'InboundShipment' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AwdApi#get_inbound_shipment\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Retrieves a summary of all the inbound AWD shipments associated with a merchant, with the ability to apply optional filters.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 1 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param [Hash] opts the optional parameters
    # @option opts [String] :sort_by Field to sort results by. By default, the response will be sorted by UPDATED_AT.
    # @option opts [String] :sort_order Sort the response in ASCENDING or DESCENDING order. By default, the response will be sorted in DESCENDING order.
    # @option opts [String] :shipment_status Filter by inbound shipment status.
    # @option opts [DateTime] :updated_after List the inbound shipments that were updated after a certain time (inclusive). The date must be in &lt;a href&#x3D;&#x27;https://developer-docs.amazon.com/sp-api/docs/iso-8601&#x27;&gt;ISO 8601&lt;/a&gt; format.
    # @option opts [DateTime] :updated_before List the inbound shipments that were updated before a certain time (inclusive). The date must be in &lt;a href&#x3D;&#x27;https://developer-docs.amazon.com/sp-api/docs/iso-8601&#x27;&gt;ISO 8601&lt;/a&gt; format.
    # @option opts [Integer] :max_results Maximum number of results to return. (default to 25)
    # @option opts [String] :next_token Token to retrieve the next set of paginated results.
    # @return [ShipmentListing]
    def list_inbound_shipments(opts = {})
      data, _status_code, _headers = list_inbound_shipments_with_http_info(opts)
      data
    end

    # Retrieves a summary of all the inbound AWD shipments associated with a merchant, with the ability to apply optional filters.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 1 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param [Hash] opts the optional parameters
    # @option opts [String] :sort_by Field to sort results by. By default, the response will be sorted by UPDATED_AT.
    # @option opts [String] :sort_order Sort the response in ASCENDING or DESCENDING order. By default, the response will be sorted in DESCENDING order.
    # @option opts [String] :shipment_status Filter by inbound shipment status.
    # @option opts [DateTime] :updated_after List the inbound shipments that were updated after a certain time (inclusive). The date must be in &lt;a href&#x3D;&#x27;https://developer-docs.amazon.com/sp-api/docs/iso-8601&#x27;&gt;ISO 8601&lt;/a&gt; format.
    # @option opts [DateTime] :updated_before List the inbound shipments that were updated before a certain time (inclusive). The date must be in &lt;a href&#x3D;&#x27;https://developer-docs.amazon.com/sp-api/docs/iso-8601&#x27;&gt;ISO 8601&lt;/a&gt; format.
    # @option opts [Integer] :max_results Maximum number of results to return.
    # @option opts [String] :next_token Token to retrieve the next set of paginated results.
    # @return [Array<(ShipmentListing, Integer, Hash)>] ShipmentListing data, response status code and response headers
    def list_inbound_shipments_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AwdApi.list_inbound_shipments ...'
      end
      if @api_client.config.client_side_validation && opts[:'sort_by'] && !['UPDATED_AT', 'CREATED_AT'].include?(opts[:'sort_by'])
        fail ArgumentError, 'invalid value for "sort_by", must be one of UPDATED_AT, CREATED_AT'
      end
      if @api_client.config.client_side_validation && opts[:'sort_order'] && !['ASCENDING', 'DESCENDING'].include?(opts[:'sort_order'])
        fail ArgumentError, 'invalid value for "sort_order", must be one of ASCENDING, DESCENDING'
      end
      if @api_client.config.client_side_validation && opts[:'shipment_status'] && !['CREATED', 'SHIPPED', 'IN_TRANSIT', 'RECEIVING', 'DELIVERED', 'CLOSED', 'CANCELLED'].include?(opts[:'shipment_status'])
        fail ArgumentError, 'invalid value for "shipment_status", must be one of CREATED, SHIPPED, IN_TRANSIT, RECEIVING, DELIVERED, CLOSED, CANCELLED'
      end
      # resource path
      local_var_path = '/awd/2024-05-09/inboundShipments'

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'sortBy'] = opts[:'sort_by'] if !opts[:'sort_by'].nil?
      query_params[:'sortOrder'] = opts[:'sort_order'] if !opts[:'sort_order'].nil?
      query_params[:'shipmentStatus'] = opts[:'shipment_status'] if !opts[:'shipment_status'].nil?
      query_params[:'updatedAfter'] = opts[:'updated_after'] if !opts[:'updated_after'].nil?
      query_params[:'updatedBefore'] = opts[:'updated_before'] if !opts[:'updated_before'].nil?
      query_params[:'maxResults'] = opts[:'max_results'] if !opts[:'max_results'].nil?
      query_params[:'nextToken'] = opts[:'next_token'] if !opts[:'next_token'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      return_type = opts[:return_type] || 'ShipmentListing' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AwdApi#list_inbound_shipments\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Lists AWD inventory associated with a merchant with the ability to apply optional filters.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param [Hash] opts the optional parameters
    # @option opts [String] :sku Filter by seller or merchant SKU for the item.
    # @option opts [String] :sort_order Sort the response in &#x60;ASCENDING&#x60; or &#x60;DESCENDING&#x60; order.
    # @option opts [String] :details Set to &#x60;SHOW&#x60; to return summaries with additional inventory details. Defaults to &#x60;HIDE,&#x60; which returns only inventory summary totals.
    # @option opts [String] :next_token Token to retrieve the next set of paginated results.
    # @option opts [Integer] :max_results Maximum number of results to return. (default to 25)
    # @return [InventoryListing]
    def list_inventory(opts = {})
      data, _status_code, _headers = list_inventory_with_http_info(opts)
      data
    end

    # Lists AWD inventory associated with a merchant with the ability to apply optional filters.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits in the Selling Partner API](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).
    # @param [Hash] opts the optional parameters
    # @option opts [String] :sku Filter by seller or merchant SKU for the item.
    # @option opts [String] :sort_order Sort the response in &#x60;ASCENDING&#x60; or &#x60;DESCENDING&#x60; order.
    # @option opts [String] :details Set to &#x60;SHOW&#x60; to return summaries with additional inventory details. Defaults to &#x60;HIDE,&#x60; which returns only inventory summary totals.
    # @option opts [String] :next_token Token to retrieve the next set of paginated results.
    # @option opts [Integer] :max_results Maximum number of results to return.
    # @return [Array<(InventoryListing, Integer, Hash)>] InventoryListing data, response status code and response headers
    def list_inventory_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AwdApi.list_inventory ...'
      end
      if @api_client.config.client_side_validation && opts[:'sort_order'] && !['ASCENDING', 'DESCENDING'].include?(opts[:'sort_order'])
        fail ArgumentError, 'invalid value for "sort_order", must be one of ASCENDING, DESCENDING'
      end
      if @api_client.config.client_side_validation && opts[:'details'] && !['SHOW', 'HIDE'].include?(opts[:'details'])
        fail ArgumentError, 'invalid value for "details", must be one of SHOW, HIDE'
      end
      # resource path
      local_var_path = '/awd/2024-05-09/inventory'

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'sku'] = opts[:'sku'] if !opts[:'sku'].nil?
      query_params[:'sortOrder'] = opts[:'sort_order'] if !opts[:'sort_order'].nil?
      query_params[:'details'] = opts[:'details'] if !opts[:'details'].nil?
      query_params[:'nextToken'] = opts[:'next_token'] if !opts[:'next_token'].nil?
      query_params[:'maxResults'] = opts[:'max_results'] if !opts[:'max_results'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      return_type = opts[:return_type] || 'InventoryListing' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AwdApi#list_inventory\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
