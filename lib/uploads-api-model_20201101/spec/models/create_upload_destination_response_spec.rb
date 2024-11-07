=begin
#Selling Partner API for Uploads

#The Uploads API lets you upload files that you can programmatically access using other Selling Partner APIs, such as the A+ Content API and the Messaging API.

OpenAPI spec version: 2020-11-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::UploadsApiModel20201101::CreateUploadDestinationResponse
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'CreateUploadDestinationResponse' do
  before do
    # run before each test
    @instance = AmzSpApi::UploadsApiModel20201101::CreateUploadDestinationResponse.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of CreateUploadDestinationResponse' do
    it 'should create an instance of CreateUploadDestinationResponse' do
      expect(@instance).to be_instance_of(AmzSpApi::UploadsApiModel20201101::CreateUploadDestinationResponse)
    end
  end
  describe 'test attribute "payload"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "errors"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
