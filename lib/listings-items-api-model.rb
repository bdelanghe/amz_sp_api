=begin
#Listings Items v2021-08-01

#The Selling Partner API for Listings Items (Listings Items API) provides programmatic access to selling partner listings on Amazon. Use this API in collaboration with the Selling Partner API for Product Type Definitions, which you use to retrieve the information about Amazon product types needed to use the Listings Items API.  For more information, see the [Listings Items API Use Case Guide](https://developer-docs.amazon.com/sp-api/docs/listings-items-api-v2021-08-01-use-case-guide).

OpenAPI spec version: 2021-08-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

# Common files
require 'listings-items-api-model/api_client'
require 'listings-items-api-model/api_error'
require 'listings-items-api-model/version'
require 'listings-items-api-model/configuration'

# Models
require 'listings-items-api-model/models/audience'
require 'listings-items-api-model/models/decimal'
require 'listings-items-api-model/models/error'
require 'listings-items-api-model/models/error_list'
require 'listings-items-api-model/models/fulfillment_availability'
require 'listings-items-api-model/models/issue'
require 'listings-items-api-model/models/issue_enforcement_action'
require 'listings-items-api-model/models/issue_enforcements'
require 'listings-items-api-model/models/issue_exemption'
require 'listings-items-api-model/models/item'
require 'listings-items-api-model/models/item_attributes'
require 'listings-items-api-model/models/item_identifiers'
require 'listings-items-api-model/models/item_identifiers_by_marketplace'
require 'listings-items-api-model/models/item_image'
require 'listings-items-api-model/models/item_issues'
require 'listings-items-api-model/models/item_offer_by_marketplace'
require 'listings-items-api-model/models/item_offers'
require 'listings-items-api-model/models/item_procurement'
require 'listings-items-api-model/models/item_search_results'
require 'listings-items-api-model/models/item_summaries'
require 'listings-items-api-model/models/item_summary_by_marketplace'
require 'listings-items-api-model/models/listings_item_patch_request'
require 'listings-items-api-model/models/listings_item_put_request'
require 'listings-items-api-model/models/listings_item_submission_response'
require 'listings-items-api-model/models/money'
require 'listings-items-api-model/models/pagination'
require 'listings-items-api-model/models/patch_operation'
require 'listings-items-api-model/models/points'

# APIs
require 'listings-items-api-model/api/listings_items_api'

module AmzSpApi::ListingsItemsApiModel
  class << self
    # Customize default settings for the SDK using block.
    #   AmzSpApi::ListingsItemsApiModel.configure do |config|
    #     config.username = "xxx"
    #     config.password = "xxx"
    #   end
    # If no block given, return the default Configuration object.
    def configure
      if block_given?
        yield(Configuration.default)
      else
        Configuration.default
      end
    end
  end
end
