=begin
#Fulfillment Inbound v2024-03-20

#The Selling Partner API for Fulfillment By Amazon (FBA) Inbound. The FBA Inbound API enables building inbound workflows to create, manage, and send shipments into Amazon's fulfillment network. The API has interoperability with the Send-to-Amazon user interface.

OpenAPI spec version: 2024-03-20

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::FulfillmentInboundApiModel
  class Stackability
    STACKABLE = 'STACKABLE'.freeze
    NON_STACKABLE = 'NON_STACKABLE'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = Stackability.constants.select { |c| Stackability::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #Stackability" if constantValues.empty?
      value
    end
  end
end
