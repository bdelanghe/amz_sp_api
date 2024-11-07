=begin
#Selling Partner API for Catalog Items

#The Selling Partner API for Catalog Items provides programmatic access to information about items in the Amazon catalog.  For more information, see the [Catalog Items API Use Case Guide](doc:catalog-items-api-v2020-12-01-use-case-guide).

OpenAPI spec version: 2020-12-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::CatalogItemsApiModel20201201::ItemVariationsByMarketplace
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'ItemVariationsByMarketplace' do
  before do
    # run before each test
    @instance = AmzSpApi::CatalogItemsApiModel20201201::ItemVariationsByMarketplace.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of ItemVariationsByMarketplace' do
    it 'should create an instance of ItemVariationsByMarketplace' do
      expect(@instance).to be_instance_of(AmzSpApi::CatalogItemsApiModel20201201::ItemVariationsByMarketplace)
    end
  end
  describe 'test attribute "marketplace_id"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "asins"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "variation_type"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
      # validator = Petstore::EnumTest::EnumAttributeValidator.new('String', ["PARENT", "CHILD"])
      # validator.allowable_values.each do |value|
      #   expect { @instance.variation_type = value }.not_to raise_error
      # end
    end
  end

end
