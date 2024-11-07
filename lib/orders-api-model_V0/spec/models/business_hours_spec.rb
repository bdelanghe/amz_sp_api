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

# Unit tests for AmzSpApi::OrdersApiModelV0::BusinessHours
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'BusinessHours' do
  before do
    # run before each test
    @instance = AmzSpApi::OrdersApiModelV0::BusinessHours.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of BusinessHours' do
    it 'should create an instance of BusinessHours' do
      expect(@instance).to be_instance_of(AmzSpApi::OrdersApiModelV0::BusinessHours)
    end
  end
  describe 'test attribute "day_of_week"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
      # validator = Petstore::EnumTest::EnumAttributeValidator.new('String', ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"])
      # validator.allowable_values.each do |value|
      #   expect { @instance.day_of_week = value }.not_to raise_error
      # end
    end
  end

  describe 'test attribute "open_intervals"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
