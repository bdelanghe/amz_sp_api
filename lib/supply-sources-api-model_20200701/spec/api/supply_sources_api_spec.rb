=begin
#Selling Partner API for Supply Sources

#Manage configurations and capabilities of seller supply sources.

OpenAPI spec version: 2020-07-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'

# Unit tests for AmzSpApi::SupplySourcesApiModel20200701::SupplySourcesApi
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'SupplySourcesApi' do
  before do
    # run before each test
    @instance = AmzSpApi::SupplySourcesApiModel20200701::SupplySourcesApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SupplySourcesApi' do
    it 'should create an instance of SupplySourcesApi' do
      expect(@instance).to be_instance_of(AmzSpApi::SupplySourcesApiModel20200701::SupplySourcesApi)
    end
  end

  # unit tests for archive_supply_source
  # Archive a supply source, making it inactive. Cannot be undone.
  # @param supply_source_id The unique identifier of a supply source.
  # @param [Hash] opts the optional parameters
  # @return [ErrorList]
  describe 'archive_supply_source test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for create_supply_source
  # Create a new supply source.
  # @param body A request to create a supply source.
  # @param [Hash] opts the optional parameters
  # @return [CreateSupplySourceResponse]
  describe 'create_supply_source test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for get_supply_source
  # Retrieve a supply source.
  # @param supply_source_id The unique identifier of a supply source.
  # @param [Hash] opts the optional parameters
  # @return [SupplySource]
  describe 'get_supply_source test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for get_supply_sources
  # The path to retrieve paginated supply sources.
  # @param [Hash] opts the optional parameters
  # @option opts [String] :next_page_token The pagination token to retrieve a specific page of results.
  # @option opts [BigDecimal] :page_size The number of supply sources to return per paginated request.
  # @return [GetSupplySourcesResponse]
  describe 'get_supply_sources test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for update_supply_source
  # Update the configuration and capabilities of a supply source.
  # @param supply_source_id The unique identitier of a supply source.
  # @param [Hash] opts the optional parameters
  # @option opts [UpdateSupplySourceRequest] :body 
  # @return [ErrorList]
  describe 'update_supply_source test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for update_supply_source_status
  # Update the status of a supply source.
  # @param supply_source_id The unique identifier of a supply source.
  # @param [Hash] opts the optional parameters
  # @option opts [UpdateSupplySourceStatusRequest] :body 
  # @return [ErrorList]
  describe 'update_supply_source_status test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
