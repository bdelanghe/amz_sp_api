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

# Unit tests for AmzSpApi::ApplicationIntegrationsApiModel::CreateNotificationRequest
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'CreateNotificationRequest' do
  before do
    # run before each test
    @instance = AmzSpApi::ApplicationIntegrationsApiModel::CreateNotificationRequest.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of CreateNotificationRequest' do
    it 'should create an instance of CreateNotificationRequest' do
      expect(@instance).to be_instance_of(AmzSpApi::ApplicationIntegrationsApiModel::CreateNotificationRequest)
    end
  end
  describe 'test attribute "template_id"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "notification_parameters"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "marketplace_id"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
