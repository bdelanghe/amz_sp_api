=begin
#Selling Partner API for Pricing

#The Selling Partner API for Pricing helps you programmatically retrieve product pricing and offer pricing information for Amazon Marketplace products.  For more information, refer to the [Product Pricing v2022-05-01 Use Case Guide](https://developer-docs.amazon.com/sp-api/docs/product-pricing-api-v2022-05-01-use-case-guide).

OpenAPI spec version: 2022-05-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::ProductPricingApiModel20220501
  class Condition
    NEW = 'New'.freeze
    USED = 'Used'.freeze
    COLLECTIBLE = 'Collectible'.freeze
    REFURBISHED = 'Refurbished'.freeze
    CLUB = 'Club'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = Condition.constants.select { |c| Condition::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #Condition" if constantValues.empty?
      value
    end
  end
end
