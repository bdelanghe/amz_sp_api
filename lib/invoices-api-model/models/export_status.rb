=begin
#The Selling Partner API for Invoices.

#Use the Selling Partner API for Invoices to retrieve and manage invoice-related operations, which can help selling partners manage their bookkeeping processes.

OpenAPI spec version: 2024-06-19

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::InvoicesApiModel
  class ExportStatus
    REQUESTED = 'REQUESTED'.freeze
    PROCESSING = 'PROCESSING'.freeze
    DONE = 'DONE'.freeze
    ERROR = 'ERROR'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = ExportStatus.constants.select { |c| ExportStatus::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #ExportStatus" if constantValues.empty?
      value
    end
  end
end
