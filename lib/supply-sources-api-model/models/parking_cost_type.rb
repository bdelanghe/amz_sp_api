=begin
#Selling Partner API for Supply Sources

#Manage configurations and capabilities of seller supply sources.

OpenAPI spec version: 2020-07-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::SupplySourcesApiModel
  class ParkingCostType
    FREE = 'Free'.freeze
    OTHER = 'Other'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = ParkingCostType.constants.select { |c| ParkingCostType::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #ParkingCostType" if constantValues.empty?
      value
    end
  end
end
