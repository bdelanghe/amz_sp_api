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

# Unit tests for AmzSpApi::InvoicesApiModel::FileFormat
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'FileFormat' do
  before do
    # run before each test
    @instance = AmzSpApi::InvoicesApiModel::FileFormat.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of FileFormat' do
    it 'should create an instance of FileFormat' do
      expect(@instance).to be_instance_of(AmzSpApi::InvoicesApiModel::FileFormat)
    end
  end
end
