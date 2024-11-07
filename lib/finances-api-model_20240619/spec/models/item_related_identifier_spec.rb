=begin
#The Selling Partner API for Finances

#The Selling Partner API for Finances provides financial information relevant to a seller's business. You can obtain financial events for a given order or date range without having to wait until a statement period closes.

OpenAPI spec version: 2024-06-19

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::FinancesApiModel20240619::ItemRelatedIdentifier
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'ItemRelatedIdentifier' do
  before do
    # run before each test
    @instance = AmzSpApi::FinancesApiModel20240619::ItemRelatedIdentifier.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of ItemRelatedIdentifier' do
    it 'should create an instance of ItemRelatedIdentifier' do
      expect(@instance).to be_instance_of(AmzSpApi::FinancesApiModel20240619::ItemRelatedIdentifier)
    end
  end
  describe 'test attribute "item_related_identifier_name"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
      # validator = Petstore::EnumTest::EnumAttributeValidator.new('String', ["ORDER_ADJUSTMENT_ITEM_ID", "COUPON_ID", "REMOVAL_SHIPMENT_ITEM_ID", "TRANSACTION_ID"])
      # validator.allowable_values.each do |value|
      #   expect { @instance.item_related_identifier_name = value }.not_to raise_error
      # end
    end
  end

  describe 'test attribute "item_related_identifier_value"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
