# amz_sp_api

AmzSpApi — Unofficial Ruby gem for the Amazon Selling Partner API (SP‑API).

This SDK is mechanically generated from the upstream Amazon Selling Partner API OpenAPI models
(https://github.com/amzn/selling-partner-api-models). Generation is deterministic and pinned to a
specific upstream commit SHA.

Generation flow:
- `pull_models.sh` snapshots the upstream `models/` directory at a specific commit.
- `codegen.sh` runs Swagger Codegen against that snapshot and writes generated output to `lib/`.
- `release.sh` commits the generated artifacts and tags the release as
  `amzn/selling-partner-api-models/<short_sha>`, with commit and tag messages linking to the exact
  upstream models used.

All generated files include provenance comments pointing back to the exact upstream models commit.
Hand‑maintained files are intentionally kept separate from generated output.

Auto-generated documentation is nested here:  This is a handy way to see all the API model class names and corresponding files you need to require for them, e.g. require 'finances-api-model' to use https://www.rubydoc.info/gems/amz_sp_api/AmzSpApi/FinancesApiModel/DefaultApi

For authoritative API behavior and business rules, always refer to the official Amazon SP‑API documentation.

but https://developer-docs.amazon.com/sp-api is more comprehensive. 

## Installation

Add the gem to your Gemfile as per https://rubygems.org/gems/amz_sp_api

## Getting Started

Please follow the [installation](#installation) procedure and then run the following code, see [sp_configuration.rb](lib/sp_configuration.rb) for all options:
```ruby
# Load the gem and specific api model you'd like to use

require 'amz_sp_api'
require 'fulfillment-outbound-api-model'

  AmzSpApi.configure do |config|
    config.refresh_token = 
    config.client_id = 
    config.client_secret = 

    # either use these:
    config.aws_access_key_id = 
    config.aws_secret_access_key = 

    # OR config.credentials_provider which is passed along to https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Sigv4/Signer.html, e.g.
    # require 'aws-sdk-core'
    # config.credentials_provider = Aws::STS::Client.new(
    #     region: AmzSpApi::SpConfiguration::AWS_REGION_MAP['eu'],
    #     access_key_id: ,
    #     secret_access_key: 
    #   ).assume_role(role_arn: , role_session_name: SecureRandom.uuid)

    config.region = 'eu'
    config.timeout = 20 # seconds
    # config.debugging = true

    # optional lambdas for caching LWA access token instead of requesting it each time, e.g.:
    config.save_access_token = -> (access_token_key, token) do
      Rails.cache.write("SPAPI-TOKEN-#{access_token_key}", token[:access_token], expires_in: token[:expires_in] - 60)
    end
    config.get_access_token = -> (access_token_key) { Rails.cache.read("SPAPI-TOKEN-#{access_token_key}") }
  end

  begin
    api = AmzSpApi::FulfillmentOutboundApiModel::FbaOutboundApi.new(AmzSpApi::SpApiClient.new)
    p api.list_all_fulfillment_orders.payload
  rescue AmzSpApi::ApiError => e
    puts "Exception when calling SP-API: #{e}"
  end
```

## Restricted operations

Configure as per above but also create a new client for each restrictedResources you need, e.g.:

```
require 'orders-api-model'

client = AmzSpApi::RestrictedSpApiClient.new({
  'restrictedResources' => [
    {
      'method' => 'GET',
      'path' => "/orders/v0/orders",
      'dataElements' => ['buyerInfo', 'shippingAddress']
    }
  ]
})
api_orders = AmzSpApi::OrdersApiModel::OrdersV0Api.new(client)
api_orders.get_orders(marketplace_ids, created_after: 1.day.ago.iso8601)

client = AmzSpApi::RestrictedSpApiClient.new({
  'restrictedResources' => [
    {
      'method' => 'GET',
      'path' => "/orders/v0/orders/#{my_order_id}",
      'dataElements' => ['buyerInfo', 'shippingAddress']
    }
  ]
})
api_orders = AmzSpApi::OrdersApiModel::OrdersV0Api.new(client)
api_orders.get_order(my_order_id)

# or you can use models AmzSpApi::RestrictedSpApiClient.new(AmzSpApi::TokensApiModel::CreateRestrictedDataTokenRequest.new(restricted_resources: [
        AmzSpApi::TokensApiModel::RestrictedResource.new(...
```

## Feeds and reports

This gem also offers encrypt/decrypt helper methods for feeds and reports, but actually using that API as per https://developer-docs.amazon.com/sp-api/docs/ requires the following calls, e.g. for feeds but reports is the same pattern:

```ruby
feeds = AmzSpApi::FeedsApiModel::FeedsApi.new(AmzSpApi::SpApiClient.new)
response = feeds.create_feed_document({"contentType" => content_type})
# PUT to response.url with lowercase "content-type" header, it's already pre-signed
response = feeds.create_feed({"feedType" => feed_type, "marketplaceIds" => marketplace_ids, "inputFeedDocumentId" => response.feed_document_id})
response = feeds.get_feed(response.feed_id)
result_feed_document_id = response.result_feed_document_id # present once it is successful
response = feeds.get_feed_document(result_feed_document_id)
# GET response.url into compressed, again it's pre-signed so no authorization needed
report = AmzSpApi.inflate_document(compressed, response)
# you should capture the HTTP headers from downloading url as well since it's often Cp1252
report.force_encoding($1) if headers['Content-Type'] =~ /charset *= *([^;]+)/
CSV.parse(report, headers: true, col_sep: "\t", liberal_parsing: true) # if it's a CSV report type
```

## Thanks

to https://github.com/patterninc/muffin_man as the basis for [sp_api_client.rb](lib/sp_api_client.rb)
