=begin
#Catalog Items v2022-04-01

#The Selling Partner API for Catalog Items provides programmatic access to information about items in the Amazon catalog.  For more information, refer to the [Catalog Items API Use Case Guide](doc:catalog-items-api-v2022-04-01-use-case-guide).

OpenAPI spec version: 2022-04-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::CatalogItemsApiModel::ItemAttributes
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'ItemAttributes' do
  before do
    # run before each test
    @instance = AmzSpApi::CatalogItemsApiModel::ItemAttributes.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of ItemAttributes' do
    it 'should create an instance of ItemAttributes' do
      expect(@instance).to be_instance_of(AmzSpApi::CatalogItemsApiModel::ItemAttributes)
    end
  end
end
