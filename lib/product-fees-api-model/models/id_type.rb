=begin
#Selling Partner API for Product Fees

#The Selling Partner API for Product Fees lets you programmatically retrieve estimated fees for a product. You can then account for those fees in your pricing.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::ProductFeesApiModel
  class IdType
    ASIN = 'ASIN'.freeze
    SELLER_SKU = 'SellerSKU'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = IdType.constants.select { |c| IdType::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #IdType" if constantValues.empty?
      value
    end
  end
end
