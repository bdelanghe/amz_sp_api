=begin
#Selling Partner API for Pricing

#The Selling Partner API for Pricing helps you programmatically retrieve product pricing and offer information for Amazon Marketplace products.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::ProductPricingApiModelV0
  class HttpMethod
    GET = 'GET'.freeze
    PUT = 'PUT'.freeze
    PATCH = 'PATCH'.freeze
    DELETE = 'DELETE'.freeze
    POST = 'POST'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = HttpMethod.constants.select { |c| HttpMethod::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #HttpMethod" if constantValues.empty?
      value
    end
  end
end
