=begin
#Catalog Items v2022-04-01

#The Selling Partner API for Catalog Items provides programmatic access to information about items in the Amazon catalog.  For more information, refer to the [Catalog Items API Use Case Guide](doc:catalog-items-api-v2022-04-01-use-case-guide).

OpenAPI spec version: 2022-04-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'

# Unit tests for AmzSpApi::CatalogItemsApiModel::CatalogItemsApi
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'CatalogItemsApi' do
  before do
    # run before each test
    @instance = AmzSpApi::CatalogItemsApiModel::CatalogItemsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of CatalogItemsApi' do
    it 'should create an instance of CatalogItemsApi' do
      expect(@instance).to be_instance_of(AmzSpApi::CatalogItemsApiModel::CatalogItemsApi)
    end
  end

  # unit tests for get_catalog_item
  # getCatalogItem
  # Retrieves details for an item in the Amazon catalog.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may observe higher rate and burst values than those shown here. For more information, refer to the [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).
  # @param asin The Amazon Standard Identification Number (ASIN) of the item.
  # @param marketplace_ids A comma-delimited list of Amazon marketplace identifiers. Data sets in the response contain data only for the specified marketplaces.
  # @param [Hash] opts the optional parameters
  # @option opts [Array<String>] :included_data A comma-delimited list of data sets to include in the response. Default: &#x60;summaries&#x60;.
  # @option opts [String] :locale Locale for retrieving localized summaries. Defaults to the primary locale of the marketplace.
  # @return [Item]
  describe 'get_catalog_item test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  # unit tests for search_catalog_items
  # searchCatalogItems
  # Search for and return a list of Amazon catalog items and associated information either by identifier or by keywords.  **Usage Plans:**  | Rate (requests per second) | Burst | | ---- | ---- | | 2 | 2 |  The &#x60;x-amzn-RateLimit-Limit&#x60; response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may observe higher rate and burst values than those shown here. For more information, refer to the [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).
  # @param marketplace_ids A comma-delimited list of Amazon marketplace identifiers for the request.
  # @param [Hash] opts the optional parameters
  # @option opts [Array<String>] :identifiers A comma-delimited list of product identifiers to search the Amazon catalog for. **Note:** Cannot be used with &#x60;keywords&#x60;.
  # @option opts [String] :identifiers_type Type of product identifiers to search the Amazon catalog for. **Note:** Required when &#x60;identifiers&#x60; are provided.
  # @option opts [Array<String>] :included_data A comma-delimited list of data sets to include in the response. Default: &#x60;summaries&#x60;.
  # @option opts [String] :locale Locale for retrieving localized summaries. Defaults to the primary locale of the marketplace.
  # @option opts [String] :seller_id A selling partner identifier, such as a seller account or vendor code. **Note:** Required when &#x60;identifiersType&#x60; is &#x60;SKU&#x60;.
  # @option opts [Array<String>] :keywords A comma-delimited list of words to search the Amazon catalog for. **Note:** Cannot be used with &#x60;identifiers&#x60;.
  # @option opts [Array<String>] :brand_names A comma-delimited list of brand names to limit the search for &#x60;keywords&#x60;-based queries. **Note:** Cannot be used with &#x60;identifiers&#x60;.
  # @option opts [Array<String>] :classification_ids A comma-delimited list of classification identifiers to limit the search for &#x60;keywords&#x60;-based queries. **Note:** Cannot be used with &#x60;identifiers&#x60;.
  # @option opts [Integer] :page_size Number of results to be returned per page.
  # @option opts [String] :page_token A token to fetch a certain page when there are multiple pages worth of results.
  # @option opts [String] :keywords_locale The language of the keywords provided for &#x60;keywords&#x60;-based queries. Defaults to the primary locale of the marketplace. **Note:** Cannot be used with &#x60;identifiers&#x60;.
  # @return [ItemSearchResults]
  describe 'search_catalog_items test' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
