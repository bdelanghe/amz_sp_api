=begin
#Selling Partner API for Merchant Fulfillment

#With the Selling Partner API for Merchant Fulfillment, you can build applications that sellers can use to purchase shipping for non-Prime and Prime orders using Amazon's Buy Shipping Services.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::MerchantFulfillmentApiModel::WeightValue
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'WeightValue' do
  before do
    # run before each test
    @instance = AmzSpApi::MerchantFulfillmentApiModel::WeightValue.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of WeightValue' do
    it 'should create an instance of WeightValue' do
      expect(@instance).to be_instance_of(AmzSpApi::MerchantFulfillmentApiModel::WeightValue)
    end
  end
end
