=begin
#Selling Partner API for Retail Procurement Payments

#The Selling Partner API for Retail Procurement Payments provides programmatic access to vendors payments data.

OpenAPI spec version: v1

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::VendorInvoicesApiModel::TransactionId
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'TransactionId' do
  before do
    # run before each test
    @instance = AmzSpApi::VendorInvoicesApiModel::TransactionId.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of TransactionId' do
    it 'should create an instance of TransactionId' do
      expect(@instance).to be_instance_of(AmzSpApi::VendorInvoicesApiModel::TransactionId)
    end
  end
  describe 'test attribute "transaction_id"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
