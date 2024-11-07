=begin
#Selling Partner API for Pricing

#The Selling Partner API for Pricing helps you programmatically retrieve product pricing and offer pricing information for Amazon Marketplace products.  For more information, refer to the [Product Pricing v2022-05-01 Use Case Guide](https://developer-docs.amazon.com/sp-api/docs/product-pricing-api-v2022-05-01-use-case-guide).

OpenAPI spec version: 2022-05-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::ProductPricingApiModel20220501::FeaturedOfferExpectedPriceResponseList
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'FeaturedOfferExpectedPriceResponseList' do
  before do
    # run before each test
    @instance = AmzSpApi::ProductPricingApiModel20220501::FeaturedOfferExpectedPriceResponseList.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of FeaturedOfferExpectedPriceResponseList' do
    it 'should create an instance of FeaturedOfferExpectedPriceResponseList' do
      expect(@instance).to be_instance_of(AmzSpApi::ProductPricingApiModel20220501::FeaturedOfferExpectedPriceResponseList)
    end
  end
end
