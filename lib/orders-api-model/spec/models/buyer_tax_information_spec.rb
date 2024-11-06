=begin
#Selling Partner API for Orders

#The Selling Partner API for Orders helps you programmatically retrieve order information. These APIs let you develop fast, flexible, custom applications in areas like order synchronization, order research, and demand-based decision support tools. The Orders API supports orders that are two years old or less. Orders more than two years old will not show in the API response.  _Note:_ The Orders API supports orders from 2016 and after for the JP, AU, and SG marketplaces.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::OrdersApiModel::BuyerTaxInformation
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'BuyerTaxInformation' do
  before do
    # run before each test
    @instance = AmzSpApi::OrdersApiModel::BuyerTaxInformation.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of BuyerTaxInformation' do
    it 'should create an instance of BuyerTaxInformation' do
      expect(@instance).to be_instance_of(AmzSpApi::OrdersApiModel::BuyerTaxInformation)
    end
  end
  describe 'test attribute "buyer_legal_company_name"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "buyer_business_address"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "buyer_tax_registration_id"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "buyer_tax_office"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
