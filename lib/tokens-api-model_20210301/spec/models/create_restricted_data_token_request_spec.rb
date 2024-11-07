=begin
#Selling Partner API for Tokens 

#The Selling Partner API for Tokens provides a secure way to access a customer's PII (Personally Identifiable Information). You can call the Tokens API to get a Restricted Data Token (RDT) for one or more restricted resources that you specify. The RDT authorizes subsequent calls to restricted operations that correspond to the restricted resources that you specified.  For more information, see the [Tokens API Use Case Guide](doc:tokens-api-use-case-guide).

OpenAPI spec version: 2021-03-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::TokensApiModel20210301::CreateRestrictedDataTokenRequest
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'CreateRestrictedDataTokenRequest' do
  before do
    # run before each test
    @instance = AmzSpApi::TokensApiModel20210301::CreateRestrictedDataTokenRequest.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of CreateRestrictedDataTokenRequest' do
    it 'should create an instance of CreateRestrictedDataTokenRequest' do
      expect(@instance).to be_instance_of(AmzSpApi::TokensApiModel20210301::CreateRestrictedDataTokenRequest)
    end
  end
  describe 'test attribute "target_application"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "restricted_resources"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
