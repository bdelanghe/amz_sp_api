=begin
#The Selling Partner API for Amazon Warehousing and Distribution

#The Selling Partner API for Amazon Warehousing and Distribution (AWD) provides programmatic access to information about AWD shipments and inventory. 

OpenAPI spec version: 2024-05-09

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::AmazonWarehousingAndDistributionModel20240509::InventorySummary
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'InventorySummary' do
  before do
    # run before each test
    @instance = AmzSpApi::AmazonWarehousingAndDistributionModel20240509::InventorySummary.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of InventorySummary' do
    it 'should create an instance of InventorySummary' do
      expect(@instance).to be_instance_of(AmzSpApi::AmazonWarehousingAndDistributionModel20240509::InventorySummary)
    end
  end
  describe 'test attribute "inventory_details"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "sku"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "total_inbound_quantity"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "total_onhand_quantity"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
