=begin
#Selling Partner API for Fulfillment Inbound

#The Selling Partner API for Fulfillment Inbound lets you create applications that create and update inbound shipments of inventory to Amazon's fulfillment network.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::FulfillmentInboundApiModelV0::GetShipmentsResult
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'GetShipmentsResult' do
  before do
    # run before each test
    @instance = AmzSpApi::FulfillmentInboundApiModelV0::GetShipmentsResult.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of GetShipmentsResult' do
    it 'should create an instance of GetShipmentsResult' do
      expect(@instance).to be_instance_of(AmzSpApi::FulfillmentInboundApiModelV0::GetShipmentsResult)
    end
  end
  describe 'test attribute "shipment_data"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "next_token"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
