=begin
#Selling Partner API for Fulfillment Inbound

#The Selling Partner API for Fulfillment Inbound lets you create applications that create and update inbound shipments of inventory to Amazon's fulfillment network.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

# Common files
require 'fulfillment-inbound-api-modelV0/api_client'
require 'fulfillment-inbound-api-modelV0/api_error'
require 'fulfillment-inbound-api-modelV0/version'
require 'fulfillment-inbound-api-modelV0/configuration'

# Models
require 'fulfillment-inbound-api-modelV0/models/asin_inbound_guidance'
require 'fulfillment-inbound-api-modelV0/models/asin_inbound_guidance_list'
require 'fulfillment-inbound-api-modelV0/models/asin_prep_instructions'
require 'fulfillment-inbound-api-modelV0/models/asin_prep_instructions_list'
require 'fulfillment-inbound-api-modelV0/models/address'
require 'fulfillment-inbound-api-modelV0/models/amazon_prep_fees_details'
require 'fulfillment-inbound-api-modelV0/models/amazon_prep_fees_details_list'
require 'fulfillment-inbound-api-modelV0/models/amount'
require 'fulfillment-inbound-api-modelV0/models/barcode_instruction'
require 'fulfillment-inbound-api-modelV0/models/big_decimal_type'
require 'fulfillment-inbound-api-modelV0/models/bill_of_lading_download_url'
require 'fulfillment-inbound-api-modelV0/models/box_contents_fee_details'
require 'fulfillment-inbound-api-modelV0/models/box_contents_source'
require 'fulfillment-inbound-api-modelV0/models/common_transport_result'
require 'fulfillment-inbound-api-modelV0/models/condition'
require 'fulfillment-inbound-api-modelV0/models/confirm_preorder_response'
require 'fulfillment-inbound-api-modelV0/models/confirm_preorder_result'
require 'fulfillment-inbound-api-modelV0/models/confirm_transport_response'
require 'fulfillment-inbound-api-modelV0/models/contact'
require 'fulfillment-inbound-api-modelV0/models/create_inbound_shipment_plan_request'
require 'fulfillment-inbound-api-modelV0/models/create_inbound_shipment_plan_response'
require 'fulfillment-inbound-api-modelV0/models/create_inbound_shipment_plan_result'
require 'fulfillment-inbound-api-modelV0/models/currency_code'
require 'fulfillment-inbound-api-modelV0/models/date_string_type'
require 'fulfillment-inbound-api-modelV0/models/dimensions'
require 'fulfillment-inbound-api-modelV0/models/error'
require 'fulfillment-inbound-api-modelV0/models/error_list'
require 'fulfillment-inbound-api-modelV0/models/error_reason'
require 'fulfillment-inbound-api-modelV0/models/estimate_transport_response'
require 'fulfillment-inbound-api-modelV0/models/get_bill_of_lading_response'
require 'fulfillment-inbound-api-modelV0/models/get_inbound_guidance_result'
require 'fulfillment-inbound-api-modelV0/models/get_labels_response'
require 'fulfillment-inbound-api-modelV0/models/get_preorder_info_response'
require 'fulfillment-inbound-api-modelV0/models/get_preorder_info_result'
require 'fulfillment-inbound-api-modelV0/models/get_prep_instructions_response'
require 'fulfillment-inbound-api-modelV0/models/get_prep_instructions_result'
require 'fulfillment-inbound-api-modelV0/models/get_shipment_items_response'
require 'fulfillment-inbound-api-modelV0/models/get_shipment_items_result'
require 'fulfillment-inbound-api-modelV0/models/get_shipments_response'
require 'fulfillment-inbound-api-modelV0/models/get_shipments_result'
require 'fulfillment-inbound-api-modelV0/models/get_transport_details_response'
require 'fulfillment-inbound-api-modelV0/models/get_transport_details_result'
require 'fulfillment-inbound-api-modelV0/models/guidance_reason'
require 'fulfillment-inbound-api-modelV0/models/guidance_reason_list'
require 'fulfillment-inbound-api-modelV0/models/inbound_guidance'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_header'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_info'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_item'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_item_list'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_list'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_plan'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_plan_item'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_plan_item_list'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_plan_list'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_plan_request_item'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_plan_request_item_list'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_request'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_response'
require 'fulfillment-inbound-api-modelV0/models/inbound_shipment_result'
require 'fulfillment-inbound-api-modelV0/models/intended_box_contents_source'
require 'fulfillment-inbound-api-modelV0/models/invalid_asin'
require 'fulfillment-inbound-api-modelV0/models/invalid_asin_list'
require 'fulfillment-inbound-api-modelV0/models/invalid_sku'
require 'fulfillment-inbound-api-modelV0/models/invalid_sku_list'
require 'fulfillment-inbound-api-modelV0/models/label_download_url'
require 'fulfillment-inbound-api-modelV0/models/label_prep_preference'
require 'fulfillment-inbound-api-modelV0/models/label_prep_type'
require 'fulfillment-inbound-api-modelV0/models/non_partnered_ltl_data_input'
require 'fulfillment-inbound-api-modelV0/models/non_partnered_ltl_data_output'
require 'fulfillment-inbound-api-modelV0/models/non_partnered_small_parcel_data_input'
require 'fulfillment-inbound-api-modelV0/models/non_partnered_small_parcel_data_output'
require 'fulfillment-inbound-api-modelV0/models/non_partnered_small_parcel_package_input'
require 'fulfillment-inbound-api-modelV0/models/non_partnered_small_parcel_package_input_list'
require 'fulfillment-inbound-api-modelV0/models/non_partnered_small_parcel_package_output'
require 'fulfillment-inbound-api-modelV0/models/non_partnered_small_parcel_package_output_list'
require 'fulfillment-inbound-api-modelV0/models/package_status'
require 'fulfillment-inbound-api-modelV0/models/pallet'
require 'fulfillment-inbound-api-modelV0/models/pallet_list'
require 'fulfillment-inbound-api-modelV0/models/partnered_estimate'
require 'fulfillment-inbound-api-modelV0/models/partnered_ltl_data_input'
require 'fulfillment-inbound-api-modelV0/models/partnered_ltl_data_output'
require 'fulfillment-inbound-api-modelV0/models/partnered_small_parcel_data_input'
require 'fulfillment-inbound-api-modelV0/models/partnered_small_parcel_data_output'
require 'fulfillment-inbound-api-modelV0/models/partnered_small_parcel_package_input'
require 'fulfillment-inbound-api-modelV0/models/partnered_small_parcel_package_input_list'
require 'fulfillment-inbound-api-modelV0/models/partnered_small_parcel_package_output'
require 'fulfillment-inbound-api-modelV0/models/partnered_small_parcel_package_output_list'
require 'fulfillment-inbound-api-modelV0/models/prep_details'
require 'fulfillment-inbound-api-modelV0/models/prep_details_list'
require 'fulfillment-inbound-api-modelV0/models/prep_guidance'
require 'fulfillment-inbound-api-modelV0/models/prep_instruction'
require 'fulfillment-inbound-api-modelV0/models/prep_instruction_list'
require 'fulfillment-inbound-api-modelV0/models/prep_owner'
require 'fulfillment-inbound-api-modelV0/models/pro_number'
require 'fulfillment-inbound-api-modelV0/models/put_transport_details_request'
require 'fulfillment-inbound-api-modelV0/models/put_transport_details_response'
require 'fulfillment-inbound-api-modelV0/models/quantity'
require 'fulfillment-inbound-api-modelV0/models/sku_inbound_guidance'
require 'fulfillment-inbound-api-modelV0/models/sku_inbound_guidance_list'
require 'fulfillment-inbound-api-modelV0/models/sku_prep_instructions'
require 'fulfillment-inbound-api-modelV0/models/sku_prep_instructions_list'
require 'fulfillment-inbound-api-modelV0/models/seller_freight_class'
require 'fulfillment-inbound-api-modelV0/models/shipment_status'
require 'fulfillment-inbound-api-modelV0/models/shipment_type'
require 'fulfillment-inbound-api-modelV0/models/time_stamp_string_type'
require 'fulfillment-inbound-api-modelV0/models/tracking_id'
require 'fulfillment-inbound-api-modelV0/models/transport_content'
require 'fulfillment-inbound-api-modelV0/models/transport_detail_input'
require 'fulfillment-inbound-api-modelV0/models/transport_detail_output'
require 'fulfillment-inbound-api-modelV0/models/transport_header'
require 'fulfillment-inbound-api-modelV0/models/transport_result'
require 'fulfillment-inbound-api-modelV0/models/transport_status'
require 'fulfillment-inbound-api-modelV0/models/unit_of_measurement'
require 'fulfillment-inbound-api-modelV0/models/unit_of_weight'
require 'fulfillment-inbound-api-modelV0/models/unsigned_int_type'
require 'fulfillment-inbound-api-modelV0/models/void_transport_response'
require 'fulfillment-inbound-api-modelV0/models/weight'

# APIs
require 'fulfillment-inbound-api-modelV0/api/fba_inbound_api'

module AmzSpApi::FulfillmentInboundApiModelV0
  class << self
    # Customize default settings for the SDK using block.
    #   AmzSpApi::FulfillmentInboundApiModelV0.configure do |config|
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
