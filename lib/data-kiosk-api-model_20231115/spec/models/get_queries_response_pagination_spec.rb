=begin
#Selling Partner API for Data Kiosk

#The Selling Partner API for Data Kiosk lets you submit GraphQL queries from a variety of schemas to help selling partners manage their businesses.

OpenAPI spec version: 2023-11-15

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::DataKioskApiModel20231115::GetQueriesResponsePagination
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'GetQueriesResponsePagination' do
  before do
    # run before each test
    @instance = AmzSpApi::DataKioskApiModel20231115::GetQueriesResponsePagination.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of GetQueriesResponsePagination' do
    it 'should create an instance of GetQueriesResponsePagination' do
      expect(@instance).to be_instance_of(AmzSpApi::DataKioskApiModel20231115::GetQueriesResponsePagination)
    end
  end
  describe 'test attribute "next_token"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
