=begin
#Selling Partner API for Vendor Direct Fulfillment Sandbox Test Data

#The Selling Partner API for Vendor Direct Fulfillment Sandbox Test Data provides programmatic access to vendor direct fulfillment sandbox test data.

OpenAPI spec version: 2021-10-28

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

module AmzSpApi::VendorDirectFulfillmentSandboxTestDataApiModel
  class VendorDFSandboxApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Submits a request to generate test order data for Vendor Direct Fulfillment API entities.
    # @param body 
    # @param [Hash] opts the optional parameters
    # @return [TransactionReference]
    def generate_order_scenarios(body, opts = {})
      data, _status_code, _headers = generate_order_scenarios_with_http_info(body, opts)
      data
    end

    # Submits a request to generate test order data for Vendor Direct Fulfillment API entities.
    # @param body 
    # @param [Hash] opts the optional parameters
    # @return [Array<(TransactionReference, Integer, Hash)>] TransactionReference data, response status code and response headers
    def generate_order_scenarios_with_http_info(body, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: VendorDFSandboxApi.generate_order_scenarios ...'
      end
      # verify the required parameter 'body' is set
      if @api_client.config.client_side_validation && body.nil?
        fail ArgumentError, "Missing the required parameter 'body' when calling VendorDFSandboxApi.generate_order_scenarios"
      end
      # resource path
      local_var_path = '/vendor/directFulfillment/sandbox/2021-10-28/orders'

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

      return_type = opts[:return_type] || 'TransactionReference' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: VendorDFSandboxApi#generate_order_scenarios\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
