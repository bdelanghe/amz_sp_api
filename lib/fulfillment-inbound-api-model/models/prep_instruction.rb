=begin
#Selling Partner API for Fulfillment Inbound

#The Selling Partner API for Fulfillment Inbound lets you create applications that create and update inbound shipments of inventory to Amazon's fulfillment network.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::FulfillmentInboundApiModel
  class PrepInstruction
    POLYBAGGING = 'Polybagging'.freeze
    BUBBLE_WRAPPING = 'BubbleWrapping'.freeze
    TAPING = 'Taping'.freeze
    BLACK_SHRINK_WRAPPING = 'BlackShrinkWrapping'.freeze
    LABELING = 'Labeling'.freeze
    HANG_GARMENT = 'HangGarment'.freeze
    SET_CREATION = 'SetCreation'.freeze
    BOXING = 'Boxing'.freeze
    REMOVE_FROM_HANGER = 'RemoveFromHanger'.freeze
    DEBUNDLE = 'Debundle'.freeze
    SUFFOCATION_STICKERING = 'SuffocationStickering'.freeze
    CAP_SEALING = 'CapSealing'.freeze
    SET_STICKERING = 'SetStickering'.freeze
    BLANK_STICKERING = 'BlankStickering'.freeze
    NO_PREP = 'NoPrep'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = PrepInstruction.constants.select { |c| PrepInstruction::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #PrepInstruction" if constantValues.empty?
      value
    end
  end
end
