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

# Unit tests for AmzSpApi::ServicesApiModelV0::AppointmentResources
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'AppointmentResources' do
  before do
    # run before each test
    @instance = AmzSpApi::ServicesApiModelV0::AppointmentResources.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of AppointmentResources' do
    it 'should create an instance of AppointmentResources' do
      expect(@instance).to be_instance_of(AmzSpApi::ServicesApiModelV0::AppointmentResources)
    end
  end
end
