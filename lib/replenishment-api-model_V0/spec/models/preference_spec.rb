=begin
#Selling Partner API for Replenishment

#The Selling Partner API for Replenishment (Replenishment API) provides programmatic access to replenishment program metrics and offers. These programs provide recurring delivery of any replenishable item at a frequency chosen by the customer.  The Replenishment API is available worldwide wherever Amazon Subscribe & Save is available or is supported. The API is available to vendors and FBA selling partners.

OpenAPI spec version: 2022-11-07

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::ReplenishmentApiModelV0::Preference
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'Preference' do
  before do
    # run before each test
    @instance = AmzSpApi::ReplenishmentApiModelV0::Preference.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of Preference' do
    it 'should create an instance of Preference' do
      expect(@instance).to be_instance_of(AmzSpApi::ReplenishmentApiModelV0::Preference)
    end
  end
  describe 'test attribute "auto_enrollment"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
