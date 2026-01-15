# AmzSpApi::FinancesApiModel::2024_06_01::DefaultApi

All URIs are relative to *https://sellingpartnerapi-na.amazon.com/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_payment_methods**](DefaultApi.md#get_payment_methods) | **GET** /finances/transfers/2024-06-01/paymentMethods | 
[**initiate_payout**](DefaultApi.md#initiate_payout) | **POST** /finances/transfers/2024-06-01/payouts | 

# **get_payment_methods**
> GetPaymentMethodsResponse get_payment_methods(marketplace_id, opts)



Returns the list of payment methods for the seller, which can be filtered by method type.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | .5 | 30 |  The `x-amzn-RateLimit-Limit` response header contains the usage plan rate limits for the operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput might have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'finances-api-model'

api_instance = AmzSpApi::FinancesApiModel::2024_06_01::DefaultApi.new
marketplace_id = 'marketplace_id_example' # String | The identifier of the marketplace from which you want to retrieve payment methods. For the list of possible marketplace identifiers, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids).
opts = { 
  payment_method_types: ['payment_method_types_example'] # Array<String> | A comma-separated list of the payment method types you want to include in the response.
}

begin
  result = api_instance.get_payment_methods(marketplace_id, opts)
  p result
rescue AmzSpApi::FinancesApiModel::2024_06_01::ApiError => e
  puts "Exception when calling DefaultApi->get_payment_methods: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **marketplace_id** | **String**| The identifier of the marketplace from which you want to retrieve payment methods. For the list of possible marketplace identifiers, refer to [Marketplace IDs](https://developer-docs.amazon.com/sp-api/docs/marketplace-ids). | 
 **payment_method_types** | [**Array&lt;String&gt;**](String.md)| A comma-separated list of the payment method types you want to include in the response. | [optional] 

### Return type

[**GetPaymentMethodsResponse**](GetPaymentMethodsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **initiate_payout**
> InitiatePayoutResponse initiate_payout(body)



Initiates an on-demand payout to the seller's default deposit method in Seller Central for the given `marketplaceId` and `accountType`, if eligible. You can only initiate one on-demand payout for each marketplace and account type within a 24-hour period.   **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 0.017 | 2 |  The `x-amzn-RateLimit-Limit` response header contains the usage plan rate limits for the operation, when available. The preceding table contains the default rate and burst values for this operation. Selling partners whose business demands require higher throughput might have higher rate and burst values than those shown here. For more information, refer to [Usage Plans and Rate Limits](https://developer-docs.amazon.com/sp-api/docs/usage-plans-and-rate-limits-in-the-sp-api).

### Example
```ruby
# load the gem
require 'finances-api-model'

api_instance = AmzSpApi::FinancesApiModel::2024_06_01::DefaultApi.new
body = AmzSpApi::FinancesApiModel::2024_06_01::InitiatePayoutRequest.new # InitiatePayoutRequest | The request body for the `initiatePayout` operation.


begin
  result = api_instance.initiate_payout(body)
  p result
rescue AmzSpApi::FinancesApiModel::2024_06_01::ApiError => e
  puts "Exception when calling DefaultApi->initiate_payout: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**InitiatePayoutRequest**](InitiatePayoutRequest.md)| The request body for the &#x60;initiatePayout&#x60; operation. | 

### Return type

[**InitiatePayoutResponse**](InitiatePayoutResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



