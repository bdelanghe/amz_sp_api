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

# Unit tests for AmzSpApi::ShippingApiModelV2::DangerousGoodsDetails
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'DangerousGoodsDetails' do
  before do
    # run before each test
    @instance = AmzSpApi::ShippingApiModelV2::DangerousGoodsDetails.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of DangerousGoodsDetails' do
    it 'should create an instance of DangerousGoodsDetails' do
      expect(@instance).to be_instance_of(AmzSpApi::ShippingApiModelV2::DangerousGoodsDetails)
    end
  end
  describe 'test attribute "united_nations_regulatory_id"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "transportation_regulatory_class"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "packing_group"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
      # validator = Petstore::EnumTest::EnumAttributeValidator.new('String', ["I", "II", "III"])
      # validator.allowable_values.each do |value|
      #   expect { @instance.packing_group = value }.not_to raise_error
      # end
    end
  end

  describe 'test attribute "packing_instruction"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
      # validator = Petstore::EnumTest::EnumAttributeValidator.new('String', ["PI965_SECTION_IA", "PI965_SECTION_IB", "PI965_SECTION_II", "PI966_SECTION_I", "PI966_SECTION_II", "PI967_SECTION_I", "PI967_SECTION_II", "PI968_SECTION_IA", "PI968_SECTION_IB", "PI969_SECTION_I", "PI969_SECTION_II", "PI970_SECTION_I", "PI970_SECTION_II"])
      # validator.allowable_values.each do |value|
      #   expect { @instance.packing_instruction = value }.not_to raise_error
      # end
    end
  end

end
