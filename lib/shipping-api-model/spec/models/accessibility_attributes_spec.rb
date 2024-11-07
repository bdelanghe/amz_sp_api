=begin
#Amazon Shipping API

#The Amazon Shipping API is designed to support outbound shipping use cases both for orders originating on Amazon-owned marketplaces as well as external channels/marketplaces. With these APIs, you can request shipping rates, create shipments, cancel shipments, and track shipments.

OpenAPI spec version: v2
Contact: swa-api-core@amazon.com
Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::ShippingApiModel::AccessibilityAttributes
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'AccessibilityAttributes' do
  before do
    # run before each test
    @instance = AmzSpApi::ShippingApiModel::AccessibilityAttributes.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of AccessibilityAttributes' do
    it 'should create an instance of AccessibilityAttributes' do
      expect(@instance).to be_instance_of(AmzSpApi::ShippingApiModel::AccessibilityAttributes)
    end
  end
  describe 'test attribute "distance"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "drive_time"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
