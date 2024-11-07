=begin
#The Selling Partner API for third party application integrations.

#With the AppIntegrations API v2024-04-01, you can send notifications to Amazon Selling Partners and display the notifications in Seller Central.

OpenAPI spec version: 2024-04-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::ApplicationIntegrationsApiModel::NotificationParameters
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'NotificationParameters' do
  before do
    # run before each test
    @instance = AmzSpApi::ApplicationIntegrationsApiModel::NotificationParameters.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of NotificationParameters' do
    it 'should create an instance of NotificationParameters' do
      expect(@instance).to be_instance_of(AmzSpApi::ApplicationIntegrationsApiModel::NotificationParameters)
    end
  end
end
