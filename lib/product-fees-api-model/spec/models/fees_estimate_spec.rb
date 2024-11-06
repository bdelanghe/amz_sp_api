=begin
#Selling Partner API for Product Fees

#The Selling Partner API for Product Fees lets you programmatically retrieve estimated fees for a product. You can then account for those fees in your pricing.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::ProductFeesApiModel::FeesEstimate
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'FeesEstimate' do
  before do
    # run before each test
    @instance = AmzSpApi::ProductFeesApiModel::FeesEstimate.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of FeesEstimate' do
    it 'should create an instance of FeesEstimate' do
      expect(@instance).to be_instance_of(AmzSpApi::ProductFeesApiModel::FeesEstimate)
    end
  end
  describe 'test attribute "time_of_fees_estimation"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "total_fees_estimate"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "fee_detail_list"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
