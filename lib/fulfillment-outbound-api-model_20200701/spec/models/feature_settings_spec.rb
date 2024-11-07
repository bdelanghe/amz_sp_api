=begin
#Selling Partner APIs for Fulfillment Outbound

#The Selling Partner API for Fulfillment Outbound lets you create applications that help a seller fulfill Multi-Channel Fulfillment orders using their inventory in Amazon's fulfillment network. You can get information on both potential and existing fulfillment orders.

OpenAPI spec version: 2020-07-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::FulfillmentOutboundApiModel20200701::FeatureSettings
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'FeatureSettings' do
  before do
    # run before each test
    @instance = AmzSpApi::FulfillmentOutboundApiModel20200701::FeatureSettings.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of FeatureSettings' do
    it 'should create an instance of FeatureSettings' do
      expect(@instance).to be_instance_of(AmzSpApi::FulfillmentOutboundApiModel20200701::FeatureSettings)
    end
  end
  describe 'test attribute "feature_name"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "feature_fulfillment_policy"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
      # validator = Petstore::EnumTest::EnumAttributeValidator.new('String', ["Required", "NotRequired"])
      # validator.allowable_values.each do |value|
      #   expect { @instance.feature_fulfillment_policy = value }.not_to raise_error
      # end
    end
  end

end
