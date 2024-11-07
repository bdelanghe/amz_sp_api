=begin
#Selling Partner API for Vendor Direct Fulfillment Sandbox Test Data

#The Selling Partner API for Vendor Direct Fulfillment Sandbox Test Data provides programmatic access to vendor direct fulfillment sandbox test data.

OpenAPI spec version: 2021-10-28

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

module AmzSpApi::VendorDirectFulfillmentSandboxTestDataApiModel20211028
  class VendorDFSandboxtransactionstatusApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Returns the status of the transaction indicated by the specified transactionId. If the transaction was successful, also returns the requested test order data.
    # @param transaction_id The transaction identifier returned in the response to the generateOrderScenarios operation.
    # @param [Hash] opts the optional parameters
    # @return [TransactionStatus]
    def get_order_scenarios(transaction_id, opts = {})
      data, _status_code, _headers = get_order_scenarios_with_http_info(transaction_id, opts)
      data
    end

    # Returns the status of the transaction indicated by the specified transactionId. If the transaction was successful, also returns the requested test order data.
    # @param transaction_id The transaction identifier returned in the response to the generateOrderScenarios operation.
    # @param [Hash] opts the optional parameters
    # @return [Array<(TransactionStatus, Integer, Hash)>] TransactionStatus data, response status code and response headers
    def get_order_scenarios_with_http_info(transaction_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: VendorDFSandboxtransactionstatusApi.get_order_scenarios ...'
      end
      # verify the required parameter 'transaction_id' is set
      if @api_client.config.client_side_validation && transaction_id.nil?
        fail ArgumentError, "Missing the required parameter 'transaction_id' when calling VendorDFSandboxtransactionstatusApi.get_order_scenarios"
      end
      # resource path
      local_var_path = '/vendor/directFulfillment/sandbox/2021-10-28/transactions/{transactionId}'.sub('{' + 'transactionId' + '}', transaction_id.to_s)

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

      return_type = opts[:return_type] || 'TransactionStatus' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: VendorDFSandboxtransactionstatusApi#get_order_scenarios\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
