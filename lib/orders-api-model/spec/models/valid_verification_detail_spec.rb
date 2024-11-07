=begin
#Orders v0

#Use the Orders Selling Partner API to programmatically retrieve order information. With this API, you can develop fast, flexible, and custom applications to manage order synchronization, perform order research, and create demand-based decision support tools.   _Note:_ For the JP, AU, and SG marketplaces, the Orders API supports orders from 2016 onward. For all other marketplaces, the Orders API supports orders for the last two years (orders older than this don't show up in the response).

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::OrdersApiModel::ValidVerificationDetail
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'ValidVerificationDetail' do
  before do
    # run before each test
    @instance = AmzSpApi::OrdersApiModel::ValidVerificationDetail.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of ValidVerificationDetail' do
    it 'should create an instance of ValidVerificationDetail' do
      expect(@instance).to be_instance_of(AmzSpApi::OrdersApiModel::ValidVerificationDetail)
    end
  end
  describe 'test attribute "verification_detail_type"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "valid_verification_statuses"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
