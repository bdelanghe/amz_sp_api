=begin
#Selling Partner API for Direct Fulfillment Orders

#The Selling Partner API for Direct Fulfillment Orders provides programmatic access to a direct fulfillment vendor's order data.

OpenAPI spec version: 2021-12-28

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

# Common files
require 'vendor-direct-fulfillment-orders-api-model_20211228/api_client'
require 'vendor-direct-fulfillment-orders-api-model_20211228/api_error'
require 'vendor-direct-fulfillment-orders-api-model_20211228/version'
require 'vendor-direct-fulfillment-orders-api-model_20211228/configuration'

# Models
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/acknowledgement_status'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/address'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/buyer_customized_info_detail'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/decimal'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/error'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/error_list'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/gift_details'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/item_quantity'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/money'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/order'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/order_acknowledgement_item'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/order_details'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/order_item'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/order_item_acknowledgement'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/order_list'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/pagination'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/party_identification'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/scheduled_delivery_shipment'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/shipment_dates'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/shipment_details'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/submit_acknowledgement_request'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/submit_acknowledgement_response'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/tax_details'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/tax_item_details'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/tax_line_item'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/tax_registration_details'
require 'vendor-direct-fulfillment-orders-api-model_20211228/models/transaction_id'

# APIs
require 'vendor-direct-fulfillment-orders-api-model_20211228/api/vendor_orders_api'

module AmzSpApi::VendorDirectFulfillmentOrdersApiModel20211228
  class << self
    # Customize default settings for the SDK using block.
    #   AmzSpApi::VendorDirectFulfillmentOrdersApiModel20211228.configure do |config|
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
