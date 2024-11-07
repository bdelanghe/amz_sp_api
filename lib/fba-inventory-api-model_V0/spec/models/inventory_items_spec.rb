=begin
#Selling Partner API for FBA Inventory

#The Selling Partner API for FBA Inventory lets you programmatically retrieve information about inventory in Amazon's fulfillment network.

OpenAPI spec version: v1

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::FbaInventoryApiModelV0::InventoryItems
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'InventoryItems' do
  before do
    # run before each test
    @instance = AmzSpApi::FbaInventoryApiModelV0::InventoryItems.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of InventoryItems' do
    it 'should create an instance of InventoryItems' do
      expect(@instance).to be_instance_of(AmzSpApi::FbaInventoryApiModelV0::InventoryItems)
    end
  end
end
