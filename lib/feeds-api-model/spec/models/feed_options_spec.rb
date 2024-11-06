=begin
#Selling Partner API for Feeds

#Effective **June 27, 2023**, the Selling Partner API for Feeds v2020-09-04 will no longer be available and all calls to it will fail. Integrations that rely on the Feeds API must migrate to [Feeds v2021-06-30](https://developer-docs.amazon.com/sp-api/docs/feeds-api-v2021-06-30-reference) to avoid service disruption.

OpenAPI spec version: 2020-09-04

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::FeedsApiModel::FeedOptions
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'FeedOptions' do
  before do
    # run before each test
    @instance = AmzSpApi::FeedsApiModel::FeedOptions.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of FeedOptions' do
    it 'should create an instance of FeedOptions' do
      expect(@instance).to be_instance_of(AmzSpApi::FeedsApiModel::FeedOptions)
    end
  end
end
