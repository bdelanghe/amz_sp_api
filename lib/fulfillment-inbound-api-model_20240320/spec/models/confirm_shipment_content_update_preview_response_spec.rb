=begin
#Fulfillment Inbound v2024-03-20

#The Selling Partner API for Fulfillment By Amazon (FBA) Inbound. The FBA Inbound API enables building inbound workflows to create, manage, and send shipments into Amazon's fulfillment network. The API has interoperability with the Send-to-Amazon user interface.

OpenAPI spec version: 2024-03-20

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::FulfillmentInboundApiModel20240320::ConfirmShipmentContentUpdatePreviewResponse
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'ConfirmShipmentContentUpdatePreviewResponse' do
  before do
    # run before each test
    @instance = AmzSpApi::FulfillmentInboundApiModel20240320::ConfirmShipmentContentUpdatePreviewResponse.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of ConfirmShipmentContentUpdatePreviewResponse' do
    it 'should create an instance of ConfirmShipmentContentUpdatePreviewResponse' do
      expect(@instance).to be_instance_of(AmzSpApi::FulfillmentInboundApiModel20240320::ConfirmShipmentContentUpdatePreviewResponse)
    end
  end
  describe 'test attribute "operation_id"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
