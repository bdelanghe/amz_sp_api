=begin
#Selling Partner API for Product Fees

#The Selling Partner API for Product Fees lets you programmatically retrieve estimated fees for a product. You can then account for those fees in your pricing.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

module AmzSpApi::ProductFeesApiModel
  class FeesApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Returns the estimated fees for the item indicated by the specified ASIN in the marketplace specified in the request body.  You can call `getMyFeesEstimateForASIN` for an item on behalf of a selling partner before the selling partner sets the item's price. The selling partner can then take estimated fees into account. Each fees request must include an original identifier. This identifier is included in the fees estimate so you can correlate a fees estimate with the original request.  **Note:** This identifier value is used to identify an estimate. Actual costs may vary. Search \"fees\" in [Seller Central](https://sellercentral.amazon.com/) and consult the store-specific fee schedule for the most up-to-date information.  **Note:** When using the `getMyFeesEstimateForASIN` operation with an ASIN, the fee estimates might be different. This is because these estimates use the item's catalog size, which might not always match the actual size of the item sent to Amazon.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).
    # @param body 
    # @param asin The Amazon Standard Identification Number (ASIN) of the item.
    # @param [Hash] opts the optional parameters
    # @return [GetMyFeesEstimateResponse]
    def get_my_fees_estimate_for_asin(body, asin, opts = {})
      data, _status_code, _headers = get_my_fees_estimate_for_asin_with_http_info(body, asin, opts)
      data
    end

    # Returns the estimated fees for the item indicated by the specified ASIN in the marketplace specified in the request body.  You can call &#x60;getMyFeesEstimateForASIN&#x60; for an item on behalf of a selling partner before the selling partner sets the item&#x27;s price. The selling partner can then take estimated fees into account. Each fees request must include an original identifier. This identifier is included in the fees estimate so you can correlate a fees estimate with the original request.  **Note:** This identifier value is used to identify an estimate. Actual costs may vary. Search \&quot;fees\&quot; in [Seller Central](https://sellercentral.amazon.com/) and consult the store-specific fee schedule for the most up-to-date information.  **Note:** When using the &#x60;getMyFeesEstimateForASIN&#x60; operation with an ASIN, the fee estimates might be different. This is because these estimates use the item&#x27;s catalog size, which might not always match the actual size of the item sent to Amazon.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 2 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).
    # @param body 
    # @param asin The Amazon Standard Identification Number (ASIN) of the item.
    # @param [Hash] opts the optional parameters
    # @return [Array<(GetMyFeesEstimateResponse, Integer, Hash)>] GetMyFeesEstimateResponse data, response status code and response headers
    def get_my_fees_estimate_for_asin_with_http_info(body, asin, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: FeesApi.get_my_fees_estimate_for_asin ...'
      end
      # verify the required parameter 'body' is set
      if @api_client.config.client_side_validation && body.nil?
        fail ArgumentError, "Missing the required parameter 'body' when calling FeesApi.get_my_fees_estimate_for_asin"
      end
      # verify the required parameter 'asin' is set
      if @api_client.config.client_side_validation && asin.nil?
        fail ArgumentError, "Missing the required parameter 'asin' when calling FeesApi.get_my_fees_estimate_for_asin"
      end
      # resource path
      local_var_path = '/products/fees/v0/items/{Asin}/feesEstimate'.sub('{' + 'Asin' + '}', asin.to_s)

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

      return_type = opts[:return_type] || 'GetMyFeesEstimateResponse' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: FeesApi#get_my_fees_estimate_for_asin\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Returns the estimated fees for the item indicated by the specified seller SKU in the marketplace specified in the request body.  **Note:** The parameters associated with this operation may contain special characters that require URL encoding to call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  You can call `getMyFeesEstimateForSKU` for an item on behalf of a selling partner before the selling partner sets the item's price. The selling partner can then take any estimated fees into account. Each fees estimate request must include an original identifier. This identifier is included in the fees estimate so that you can correlate a fees estimate with the original request.  **Note:** This identifier value is used to identify an estimate. Actual costs may vary. Search \"fees\" in [Seller Central](https://sellercentral.amazon.com/) and consult the store-specific fee schedule for the most up-to-date information.  **Note:** When sellers use the `getMyFeesEstimateForSKU` operation with their `SellerSKU`, they get accurate fees based on real item measurements, but only after they've sent their items to Amazon.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).
    # @param body 
    # @param seller_sku Used to identify an item in the given marketplace. SellerSKU is qualified by the seller&#x27;s SellerId, which is included with every operation that you submit.
    # @param [Hash] opts the optional parameters
    # @return [GetMyFeesEstimateResponse]
    def get_my_fees_estimate_for_sku(body, seller_sku, opts = {})
      data, _status_code, _headers = get_my_fees_estimate_for_sku_with_http_info(body, seller_sku, opts)
      data
    end

    # Returns the estimated fees for the item indicated by the specified seller SKU in the marketplace specified in the request body.  **Note:** The parameters associated with this operation may contain special characters that require URL encoding to call the API. To avoid errors with SKUs when encoding URLs, refer to [URL Encoding](https://developer-docs.amazon.com/sp-api/docs/url-encoding).  You can call &#x60;getMyFeesEstimateForSKU&#x60; for an item on behalf of a selling partner before the selling partner sets the item&#x27;s price. The selling partner can then take any estimated fees into account. Each fees estimate request must include an original identifier. This identifier is included in the fees estimate so that you can correlate a fees estimate with the original request.  **Note:** This identifier value is used to identify an estimate. Actual costs may vary. Search \&quot;fees\&quot; in [Seller Central](https://sellercentral.amazon.com/) and consult the store-specific fee schedule for the most up-to-date information.  **Note:** When sellers use the &#x60;getMyFeesEstimateForSKU&#x60; operation with their &#x60;SellerSKU&#x60;, they get accurate fees based on real item measurements, but only after they&#x27;ve sent their items to Amazon.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 2 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).
    # @param body 
    # @param seller_sku Used to identify an item in the given marketplace. SellerSKU is qualified by the seller&#x27;s SellerId, which is included with every operation that you submit.
    # @param [Hash] opts the optional parameters
    # @return [Array<(GetMyFeesEstimateResponse, Integer, Hash)>] GetMyFeesEstimateResponse data, response status code and response headers
    def get_my_fees_estimate_for_sku_with_http_info(body, seller_sku, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: FeesApi.get_my_fees_estimate_for_sku ...'
      end
      # verify the required parameter 'body' is set
      if @api_client.config.client_side_validation && body.nil?
        fail ArgumentError, "Missing the required parameter 'body' when calling FeesApi.get_my_fees_estimate_for_sku"
      end
      # verify the required parameter 'seller_sku' is set
      if @api_client.config.client_side_validation && seller_sku.nil?
        fail ArgumentError, "Missing the required parameter 'seller_sku' when calling FeesApi.get_my_fees_estimate_for_sku"
      end
      # resource path
      local_var_path = '/products/fees/v0/listings/{SellerSKU}/feesEstimate'.sub('{' + 'SellerSKU' + '}', seller_sku.to_s)

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

      return_type = opts[:return_type] || 'GetMyFeesEstimateResponse' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: FeesApi#get_my_fees_estimate_for_sku\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Returns the estimated fees for a list of products.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.5 | 1 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).
    # @param body 
    # @param [Hash] opts the optional parameters
    # @return [GetMyFeesEstimatesResponse]
    def get_my_fees_estimates(body, opts = {})
      data, _status_code, _headers = get_my_fees_estimates_with_http_info(body, opts)
      data
    end

    # Returns the estimated fees for a list of products.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.5 | 1 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).
    # @param body 
    # @param [Hash] opts the optional parameters
    # @return [Array<(GetMyFeesEstimatesResponse, Integer, Hash)>] GetMyFeesEstimatesResponse data, response status code and response headers
    def get_my_fees_estimates_with_http_info(body, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: FeesApi.get_my_fees_estimates ...'
      end
      # verify the required parameter 'body' is set
      if @api_client.config.client_side_validation && body.nil?
        fail ArgumentError, "Missing the required parameter 'body' when calling FeesApi.get_my_fees_estimates"
      end
      # resource path
      local_var_path = '/products/fees/v0/feesEstimate'

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

      return_type = opts[:return_type] || 'GetMyFeesEstimatesResponse' 

      auth_names = opts[:auth_names] || []
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: FeesApi#get_my_fees_estimates\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
