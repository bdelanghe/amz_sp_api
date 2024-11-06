=begin
#Selling Partner API for Shipment Invoicing

#The Selling Partner API for Shipment Invoicing helps you programmatically retrieve shipment invoice information in the Brazil marketplace for a selling partner’s Fulfillment by Amazon (FBA) orders.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::ShipmentInvoicingApiModel::ShipmentInvoiceStatusResponse
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'ShipmentInvoiceStatusResponse' do
  before do
    # run before each test
    @instance = AmzSpApi::ShipmentInvoicingApiModel::ShipmentInvoiceStatusResponse.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of ShipmentInvoiceStatusResponse' do
    it 'should create an instance of ShipmentInvoiceStatusResponse' do
      expect(@instance).to be_instance_of(AmzSpApi::ShipmentInvoicingApiModel::ShipmentInvoiceStatusResponse)
    end
  end
  describe 'test attribute "shipments"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
