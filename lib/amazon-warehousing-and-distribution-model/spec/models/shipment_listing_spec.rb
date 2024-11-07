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

# Unit tests for AmzSpApi::AmazonWarehousingAndDistributionModel::ShipmentListing
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'ShipmentListing' do
  before do
    # run before each test
    @instance = AmzSpApi::AmazonWarehousingAndDistributionModel::ShipmentListing.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of ShipmentListing' do
    it 'should create an instance of ShipmentListing' do
      expect(@instance).to be_instance_of(AmzSpApi::AmazonWarehousingAndDistributionModel::ShipmentListing)
    end
  end
  describe 'test attribute "next_token"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "shipments"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
