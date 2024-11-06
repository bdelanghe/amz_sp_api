=begin
#Selling Partner API for Services

#With the Services API, you can build applications that help service providers get and modify their service orders and manage their resources.

OpenAPI spec version: v1

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::ServicesApiModel::FixedSlotCapacityQuery
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'FixedSlotCapacityQuery' do
  before do
    # run before each test
    @instance = AmzSpApi::ServicesApiModel::FixedSlotCapacityQuery.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of FixedSlotCapacityQuery' do
    it 'should create an instance of FixedSlotCapacityQuery' do
      expect(@instance).to be_instance_of(AmzSpApi::ServicesApiModel::FixedSlotCapacityQuery)
    end
  end
  describe 'test attribute "capacity_types"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "slot_duration"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "start_date_time"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "end_date_time"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
