=begin
#The Selling Partner API for Amazon Warehousing and Distribution

#The Selling Partner API for Amazon Warehousing and Distribution (AWD) provides programmatic access to information about AWD shipments and inventory. 

OpenAPI spec version: 2024-05-09

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::AmazonWarehousingAndDistributionModel20240509
  class VolumeUnitOfMeasurement
    CU_IN = 'CU_IN'.freeze
    CBM = 'CBM'.freeze
    CC = 'CC'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = VolumeUnitOfMeasurement.constants.select { |c| VolumeUnitOfMeasurement::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #VolumeUnitOfMeasurement" if constantValues.empty?
      value
    end
  end
end
