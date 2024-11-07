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

# Unit tests for AmzSpApi::ShippingApiModelV2::GetAccessPointsResult
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'GetAccessPointsResult' do
  before do
    # run before each test
    @instance = AmzSpApi::ShippingApiModelV2::GetAccessPointsResult.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of GetAccessPointsResult' do
    it 'should create an instance of GetAccessPointsResult' do
      expect(@instance).to be_instance_of(AmzSpApi::ShippingApiModelV2::GetAccessPointsResult)
    end
  end
  describe 'test attribute "access_points_map"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
