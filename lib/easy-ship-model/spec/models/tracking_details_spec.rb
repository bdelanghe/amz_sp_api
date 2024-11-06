=begin
#Selling Partner API for Easy Ship

#The Selling Partner API for Easy Ship helps you build applications that help sellers manage and ship Amazon Easy Ship orders.  Your Easy Ship applications can:  * Get available time slots for packages to be scheduled for delivery.  * Schedule, reschedule, and cancel Easy Ship orders.  * Print labels, invoices, and warranties.  See the [Marketplace Support Table](doc:easyship-api-v2022-03-23-use-case-guide#marketplace-support-table) for the differences in Easy Ship operations by marketplace.

OpenAPI spec version: 2022-03-23

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::EasyShipModel::TrackingDetails
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'TrackingDetails' do
  before do
    # run before each test
    @instance = AmzSpApi::EasyShipModel::TrackingDetails.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of TrackingDetails' do
    it 'should create an instance of TrackingDetails' do
      expect(@instance).to be_instance_of(AmzSpApi::EasyShipModel::TrackingDetails)
    end
  end
  describe 'test attribute "tracking_id"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
