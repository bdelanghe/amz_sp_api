=begin
#The Selling Partner API for Invoices.

#Use the Selling Partner API for Invoices to retrieve and manage invoice-related operations, which can help selling partners manage their bookkeeping processes.

OpenAPI spec version: 2024-06-19

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::InvoicesApiModel20240619::InvoicesAttributes
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'InvoicesAttributes' do
  before do
    # run before each test
    @instance = AmzSpApi::InvoicesApiModel20240619::InvoicesAttributes.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of InvoicesAttributes' do
    it 'should create an instance of InvoicesAttributes' do
      expect(@instance).to be_instance_of(AmzSpApi::InvoicesApiModel20240619::InvoicesAttributes)
    end
  end
  describe 'test attribute "invoice_status_options"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "invoice_type_options"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "transaction_identifier_name_options"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "transaction_type_options"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
