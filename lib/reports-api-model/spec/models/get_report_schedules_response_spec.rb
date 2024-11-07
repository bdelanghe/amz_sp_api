=begin
#Selling Partner API for Reports

#Effective **June 27, 2024**, the Selling Partner API for Reports v2020-09-04 will no longer be available and all calls to it will fail. Integrations that rely on the Reports API must migrate to [Reports v2021-06-30](https://developer-docs.amazon.com/sp-api/docs/reports-api-v2021-06-30-reference) to avoid service disruption.

OpenAPI spec version: 2020-09-04

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::ReportsApiModel::GetReportSchedulesResponse
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'GetReportSchedulesResponse' do
  before do
    # run before each test
    @instance = AmzSpApi::ReportsApiModel::GetReportSchedulesResponse.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of GetReportSchedulesResponse' do
    it 'should create an instance of GetReportSchedulesResponse' do
      expect(@instance).to be_instance_of(AmzSpApi::ReportsApiModel::GetReportSchedulesResponse)
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
