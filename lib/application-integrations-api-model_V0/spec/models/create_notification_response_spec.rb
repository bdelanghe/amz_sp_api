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

# Unit tests for AmzSpApi::ApplicationIntegrationsApiModelV0::CreateNotificationResponse
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'CreateNotificationResponse' do
  before do
    # run before each test
    @instance = AmzSpApi::ApplicationIntegrationsApiModelV0::CreateNotificationResponse.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of CreateNotificationResponse' do
    it 'should create an instance of CreateNotificationResponse' do
      expect(@instance).to be_instance_of(AmzSpApi::ApplicationIntegrationsApiModelV0::CreateNotificationResponse)
    end
  end
  describe 'test attribute "notification_id"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
