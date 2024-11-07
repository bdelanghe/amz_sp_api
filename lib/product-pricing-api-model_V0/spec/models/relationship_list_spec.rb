=begin
#Selling Partner API for Pricing

#The Selling Partner API for Pricing helps you programmatically retrieve product pricing and offer information for Amazon Marketplace products.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::ProductPricingApiModelV0::RelationshipList
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'RelationshipList' do
  before do
    # run before each test
    @instance = AmzSpApi::ProductPricingApiModelV0::RelationshipList.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of RelationshipList' do
    it 'should create an instance of RelationshipList' do
      expect(@instance).to be_instance_of(AmzSpApi::ProductPricingApiModelV0::RelationshipList)
    end
  end
end
