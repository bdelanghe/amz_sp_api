=begin
#Selling Partner API for Orders

#The Selling Partner API for Orders helps you programmatically retrieve order information. These APIs let you develop fast, flexible, custom applications in areas like order synchronization, order research, and demand-based decision support tools. The Orders API supports orders that are two years old or less. Orders more than two years old will not show in the API response.  _Note:_ The Orders API supports orders from 2016 and after for the JP, AU, and SG marketplaces.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::OrdersApiModel
  class EasyShipShipmentStatus
    PENDING_SCHEDULE = 'PendingSchedule'.freeze
    PENDING_PICK_UP = 'PendingPickUp'.freeze
    PENDING_DROP_OFF = 'PendingDropOff'.freeze
    LABEL_CANCELED = 'LabelCanceled'.freeze
    PICKED_UP = 'PickedUp'.freeze
    DROPPED_OFF = 'DroppedOff'.freeze
    AT_ORIGIN_FC = 'AtOriginFC'.freeze
    AT_DESTINATION_FC = 'AtDestinationFC'.freeze
    DELIVERED = 'Delivered'.freeze
    REJECTED_BY_BUYER = 'RejectedByBuyer'.freeze
    UNDELIVERABLE = 'Undeliverable'.freeze
    RETURNING_TO_SELLER = 'ReturningToSeller'.freeze
    RETURNED_TO_SELLER = 'ReturnedToSeller'.freeze
    LOST = 'Lost'.freeze
    OUT_FOR_DELIVERY = 'OutForDelivery'.freeze
    DAMAGED = 'Damaged'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = EasyShipShipmentStatus.constants.select { |c| EasyShipShipmentStatus::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #EasyShipShipmentStatus" if constantValues.empty?
      value
    end
  end
end
