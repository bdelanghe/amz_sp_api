=begin
#Selling Partner API for Merchant Fulfillment

#The Selling Partner API for Merchant Fulfillment helps you build applications that let sellers purchase shipping for non-Prime and Prime orders using Amazon’s Buy Shipping Services.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::MerchantFulfillmentApiModel::AvailableCarrierWillPickUpOptionsList
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'AvailableCarrierWillPickUpOptionsList' do
  before do
    # run before each test
    @instance = AmzSpApi::MerchantFulfillmentApiModel::AvailableCarrierWillPickUpOptionsList.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of AvailableCarrierWillPickUpOptionsList' do
    it 'should create an instance of AvailableCarrierWillPickUpOptionsList' do
      expect(@instance).to be_instance_of(AmzSpApi::MerchantFulfillmentApiModel::AvailableCarrierWillPickUpOptionsList)
    end
  end
end
