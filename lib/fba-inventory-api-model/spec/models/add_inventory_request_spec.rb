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

# Unit tests for AmzSpApi::FbaInventoryApiModel::AddInventoryRequest
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'AddInventoryRequest' do
  before do
    # run before each test
    @instance = AmzSpApi::FbaInventoryApiModel::AddInventoryRequest.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of AddInventoryRequest' do
    it 'should create an instance of AddInventoryRequest' do
      expect(@instance).to be_instance_of(AmzSpApi::FbaInventoryApiModel::AddInventoryRequest)
    end
  end
  describe 'test attribute "inventory_items"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
