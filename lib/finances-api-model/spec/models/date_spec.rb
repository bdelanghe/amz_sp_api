=begin
#The Selling Partner API for Finances

#The Selling Partner API for Finances provides financial information relevant to a seller's business. You can obtain financial events for a given order or date range without having to wait until a statement period closes.

OpenAPI spec version: 2024-06-19

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::FinancesApiModel::Date
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'Date' do
  before do
    # run before each test
    @instance = AmzSpApi::FinancesApiModel::Date.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of Date' do
    it 'should create an instance of Date' do
      expect(@instance).to be_instance_of(AmzSpApi::FinancesApiModel::Date)
    end
  end
end
