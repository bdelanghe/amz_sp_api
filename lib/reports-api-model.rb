=begin
#Report v2021-06-30

#The Selling Partner API for Reports lets you retrieve and manage a variety of reports that can help selling partners manage their businesses.

OpenAPI spec version: 2021-06-30

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

# Common files
require 'reports-api-model/api_client'
require 'reports-api-model/api_error'
require 'reports-api-model/version'
require 'reports-api-model/configuration'

# Models
require 'reports-api-model/models/create_report_response'
require 'reports-api-model/models/create_report_schedule_response'
require 'reports-api-model/models/create_report_schedule_specification'
require 'reports-api-model/models/create_report_specification'
require 'reports-api-model/models/error'
require 'reports-api-model/models/error_list'
require 'reports-api-model/models/get_reports_response'
require 'reports-api-model/models/report'
require 'reports-api-model/models/report_document'
require 'reports-api-model/models/report_list'
require 'reports-api-model/models/report_options'
require 'reports-api-model/models/report_schedule'
require 'reports-api-model/models/report_schedule_list'

# APIs
require 'reports-api-model/api/reports_api'

module AmzSpApi::ReportsApiModel
  class << self
    # Customize default settings for the SDK using block.
    #   AmzSpApi::ReportsApiModel.configure do |config|
    #     config.username = "xxx"
    #     config.password = "xxx"
    #   end
    # If no block given, return the default Configuration object.
    def configure
      if block_given?
        yield(Configuration.default)
      else
        Configuration.default
      end
    end
  end
end
