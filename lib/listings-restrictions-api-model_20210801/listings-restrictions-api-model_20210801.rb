=begin
#Selling Partner API for Listings Restrictions

#The Selling Partner API for Listings Restrictions provides programmatic access to restrictions on Amazon catalog listings.  For more information, see the [Listings Restrictions API Use Case Guide](doc:listings-restrictions-api-v2021-08-01-use-case-guide).

OpenAPI spec version: 2021-08-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

# Common files
require 'listings-restrictions-api-model_20210801/api_client'
require 'listings-restrictions-api-model_20210801/api_error'
require 'listings-restrictions-api-model_20210801/version'
require 'listings-restrictions-api-model_20210801/configuration'

# Models
require 'listings-restrictions-api-model_20210801/models/error'
require 'listings-restrictions-api-model_20210801/models/error_list'
require 'listings-restrictions-api-model_20210801/models/link'
require 'listings-restrictions-api-model_20210801/models/reason'
require 'listings-restrictions-api-model_20210801/models/restriction'
require 'listings-restrictions-api-model_20210801/models/restriction_list'

# APIs
require 'listings-restrictions-api-model_20210801/api/listings_api'

module AmzSpApi::ListingsRestrictionsApiModel20210801
  class << self
    # Customize default settings for the SDK using block.
    #   AmzSpApi::ListingsRestrictionsApiModel20210801.configure do |config|
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
