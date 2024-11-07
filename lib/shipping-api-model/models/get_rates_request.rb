=begin
#Amazon Shipping API

#The Amazon Shipping API is designed to support outbound shipping use cases both for orders originating on Amazon-owned marketplaces as well as external channels/marketplaces. With these APIs, you can request shipping rates, create shipments, cancel shipments, and track shipments.

OpenAPI spec version: v2
Contact: swa-api-core@amazon.com
Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::ShippingApiModel
  # The request schema for the getRates operation. When the channelType is Amazon, the shipTo address is not required and will be ignored.
  class GetRatesRequest
    attr_accessor :ship_to

    attr_accessor :ship_from

    attr_accessor :return_to

    # The ship date and time (the requested pickup). This defaults to the current date and time.
    attr_accessor :ship_date

    attr_accessor :shipper_instruction

    attr_accessor :packages

    attr_accessor :value_added_services

    attr_accessor :tax_details

    attr_accessor :channel_details

    attr_accessor :client_reference_details

    attr_accessor :shipment_type

    attr_accessor :destination_access_point_details

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'ship_to' => :'shipTo',
        :'ship_from' => :'shipFrom',
        :'return_to' => :'returnTo',
        :'ship_date' => :'shipDate',
        :'shipper_instruction' => :'shipperInstruction',
        :'packages' => :'packages',
        :'value_added_services' => :'valueAddedServices',
        :'tax_details' => :'taxDetails',
        :'channel_details' => :'channelDetails',
        :'client_reference_details' => :'clientReferenceDetails',
        :'shipment_type' => :'shipmentType',
        :'destination_access_point_details' => :'destinationAccessPointDetails'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'ship_to' => :'Object',
        :'ship_from' => :'Object',
        :'return_to' => :'Object',
        :'ship_date' => :'Object',
        :'shipper_instruction' => :'Object',
        :'packages' => :'Object',
        :'value_added_services' => :'Object',
        :'tax_details' => :'Object',
        :'channel_details' => :'Object',
        :'client_reference_details' => :'Object',
        :'shipment_type' => :'Object',
        :'destination_access_point_details' => :'Object'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
      ])
    end
  
    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `AmzSpApi::ShippingApiModel::GetRatesRequest` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `AmzSpApi::ShippingApiModel::GetRatesRequest`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'ship_to')
        self.ship_to = attributes[:'ship_to']
      end

      if attributes.key?(:'ship_from')
        self.ship_from = attributes[:'ship_from']
      end

      if attributes.key?(:'return_to')
        self.return_to = attributes[:'return_to']
      end

      if attributes.key?(:'ship_date')
        self.ship_date = attributes[:'ship_date']
      end

      if attributes.key?(:'shipper_instruction')
        self.shipper_instruction = attributes[:'shipper_instruction']
      end

      if attributes.key?(:'packages')
        self.packages = attributes[:'packages']
      end

      if attributes.key?(:'value_added_services')
        self.value_added_services = attributes[:'value_added_services']
      end

      if attributes.key?(:'tax_details')
        self.tax_details = attributes[:'tax_details']
      end

      if attributes.key?(:'channel_details')
        self.channel_details = attributes[:'channel_details']
      end

      if attributes.key?(:'client_reference_details')
        self.client_reference_details = attributes[:'client_reference_details']
      end

      if attributes.key?(:'shipment_type')
        self.shipment_type = attributes[:'shipment_type']
      end

      if attributes.key?(:'destination_access_point_details')
        self.destination_access_point_details = attributes[:'destination_access_point_details']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @ship_from.nil?
        invalid_properties.push('invalid value for "ship_from", ship_from cannot be nil.')
      end

      if @packages.nil?
        invalid_properties.push('invalid value for "packages", packages cannot be nil.')
      end

      if @channel_details.nil?
        invalid_properties.push('invalid value for "channel_details", channel_details cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @ship_from.nil?
      return false if @packages.nil?
      return false if @channel_details.nil?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          ship_to == o.ship_to &&
          ship_from == o.ship_from &&
          return_to == o.return_to &&
          ship_date == o.ship_date &&
          shipper_instruction == o.shipper_instruction &&
          packages == o.packages &&
          value_added_services == o.value_added_services &&
          tax_details == o.tax_details &&
          channel_details == o.channel_details &&
          client_reference_details == o.client_reference_details &&
          shipment_type == o.shipment_type &&
          destination_access_point_details == o.destination_access_point_details
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [ship_to, ship_from, return_to, ship_date, shipper_instruction, packages, value_added_services, tax_details, channel_details, client_reference_details, shipment_type, destination_access_point_details].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def self.build_from_hash(attributes)
      new.build_from_hash(attributes)
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      self.class.openapi_types.each_pair do |key, type|
        if type =~ /\AArray<(.*)>/i
          # check to ensure the input is an array given that the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map { |v| _deserialize($1, v) })
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        elsif attributes[self.class.attribute_map[key]].nil? && self.class.openapi_nullable.include?(key)
          self.send("#{key}=", nil)
        end
      end

      self
    end

    # Deserializes the data based on type
    # @param string type Data type
    # @param string value Value to be deserialized
    # @return [Object] Deserialized data
    def _deserialize(type, value)
      case type.to_sym
      when :DateTime
        DateTime.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :Boolean
        if value.to_s =~ /\A(true|t|yes|y|1)\z/i
          true
        else
          false
        end
      when :Object
        # generic object (usually a Hash), return directly
        value
      when /\AArray<(?<inner_type>.+)>\z/
        inner_type = Regexp.last_match[:inner_type]
        value.map { |v| _deserialize(inner_type, v) }
      when /\AHash<(?<k_type>.+?), (?<v_type>.+)>\z/
        k_type = Regexp.last_match[:k_type]
        v_type = Regexp.last_match[:v_type]
        {}.tap do |hash|
          value.each do |k, v|
            hash[_deserialize(k_type, k)] = _deserialize(v_type, v)
          end
        end
      else # model
        AmzSpApi::ShippingApiModel.const_get(type).build_from_hash(value)
      end
    end

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_hash (backward compatibility)
    # @return [Hash] Returns the object in the form of hash
    def to_body
      to_hash
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        if value.nil?
          is_nullable = self.class.openapi_nullable.include?(attr)
          next if !is_nullable || (is_nullable && !instance_variable_defined?(:"@#{attr}"))
        end

        hash[param] = _to_hash(value)
      end
      hash
    end

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map { |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end  end
end
