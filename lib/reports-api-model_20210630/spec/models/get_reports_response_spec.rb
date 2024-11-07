=begin
#Report v2021-06-30

#The Selling Partner API for Reports lets you retrieve and manage a variety of reports that can help selling partners manage their businesses.

OpenAPI spec version: 2021-06-30

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::ReportsApiModel20210630::GetReportsResponse
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'GetReportsResponse' do
  before do
    # run before each test
    @instance = AmzSpApi::ReportsApiModel20210630::GetReportsResponse.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of GetReportsResponse' do
    it 'should create an instance of GetReportsResponse' do
      expect(@instance).to be_instance_of(AmzSpApi::ReportsApiModel20210630::GetReportsResponse)
    end
  end
  describe 'test attribute "reports"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "next_token"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
