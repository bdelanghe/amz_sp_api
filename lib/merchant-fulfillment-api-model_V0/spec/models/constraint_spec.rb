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

# Unit tests for AmzSpApi::MerchantFulfillmentApiModelV0::Constraint
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'Constraint' do
  before do
    # run before each test
    @instance = AmzSpApi::MerchantFulfillmentApiModelV0::Constraint.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of Constraint' do
    it 'should create an instance of Constraint' do
      expect(@instance).to be_instance_of(AmzSpApi::MerchantFulfillmentApiModelV0::Constraint)
    end
  end
  describe 'test attribute "validation_reg_ex"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "validation_string"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
