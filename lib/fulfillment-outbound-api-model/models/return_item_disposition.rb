=begin
#Selling Partner APIs for Fulfillment Outbound

#The Selling Partner API for Fulfillment Outbound lets you create applications that help a seller fulfill Multi-Channel Fulfillment orders using their inventory in Amazon's fulfillment network. You can get information on both potential and existing fulfillment orders.

OpenAPI spec version: 2020-07-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.51
=end

require 'date'

module AmzSpApi::FulfillmentOutboundApiModel
  class ReturnItemDisposition
    SELLABLE = 'Sellable'.freeze
    DEFECTIVE = 'Defective'.freeze
    CUSTOMER_DAMAGED = 'CustomerDamaged'.freeze
    CARRIER_DAMAGED = 'CarrierDamaged'.freeze
    FULFILLER_DAMAGED = 'FulfillerDamaged'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = ReturnItemDisposition.constants.select { |c| ReturnItemDisposition::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #ReturnItemDisposition" if constantValues.empty?
      value
    end
  end
end
