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

# Unit tests for AmzSpApi::VendorShipmentsApiModelV0::TotalWeight
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'TotalWeight' do
  before do
    # run before each test
    @instance = AmzSpApi::VendorShipmentsApiModelV0::TotalWeight.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of TotalWeight' do
    it 'should create an instance of TotalWeight' do
      expect(@instance).to be_instance_of(AmzSpApi::VendorShipmentsApiModelV0::TotalWeight)
    end
  end
  describe 'test attribute "unit_of_measure"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
      # validator = Petstore::EnumTest::EnumAttributeValidator.new('String', ["POUNDS", "OUNCES", "GRAMS", "KILOGRAMS"])
      # validator.allowable_values.each do |value|
      #   expect { @instance.unit_of_measure = value }.not_to raise_error
      # end
    end
  end

  describe 'test attribute "amount"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
