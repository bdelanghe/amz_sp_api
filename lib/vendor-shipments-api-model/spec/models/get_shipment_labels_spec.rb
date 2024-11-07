=begin
#Vendor Shipments v1

#The Selling Partner API for Retail Procurement Shipments provides programmatic access to retail shipping data for vendors.

OpenAPI spec version: v1

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::VendorShipmentsApiModel::GetShipmentLabels
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'GetShipmentLabels' do
  before do
    # run before each test
    @instance = AmzSpApi::VendorShipmentsApiModel::GetShipmentLabels.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of GetShipmentLabels' do
    it 'should create an instance of GetShipmentLabels' do
      expect(@instance).to be_instance_of(AmzSpApi::VendorShipmentsApiModel::GetShipmentLabels)
    end
  end
  describe 'test attribute "payload"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "errors"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
