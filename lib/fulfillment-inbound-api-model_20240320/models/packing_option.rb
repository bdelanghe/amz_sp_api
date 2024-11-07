=begin
#Fulfillment Inbound v2024-03-20

#The Selling Partner API for Fulfillment By Amazon (FBA) Inbound. The FBA Inbound API enables building inbound workflows to create, manage, and send shipments into Amazon's fulfillment network. The API has interoperability with the Send-to-Amazon user interface.

OpenAPI spec version: 2024-03-20

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::FulfillmentInboundApiModel20240320
  # A packing option contains a set of pack groups plus additional information about the packing option, such as any discounts or fees if it's selected.
  class PackingOption
    # Discount for the offered option.
    attr_accessor :discounts

    # The time at which this packing option is no longer valid. In [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) datetime format with pattern `yyyy-MM-ddTHH:mm:ss.sssZ`.
    attr_accessor :expiration

    # Fee for the offered option.
    attr_accessor :fees

    # Packing group IDs.
    attr_accessor :packing_groups

    # Identifier of a packing option.
    attr_accessor :packing_option_id

    # The status of the packing option. Possible values: `OFFERED`, `ACCEPTED`, `EXPIRED`.
    attr_accessor :status

    # List of supported shipping modes.
    attr_accessor :supported_shipping_configurations

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'discounts' => :'discounts',
        :'expiration' => :'expiration',
        :'fees' => :'fees',
        :'packing_groups' => :'packingGroups',
        :'packing_option_id' => :'packingOptionId',
        :'status' => :'status',
        :'supported_shipping_configurations' => :'supportedShippingConfigurations'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'discounts' => :'Object',
        :'expiration' => :'Object',
        :'fees' => :'Object',
        :'packing_groups' => :'Object',
        :'packing_option_id' => :'Object',
        :'status' => :'Object',
        :'supported_shipping_configurations' => :'Object'
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
        fail ArgumentError, "The input argument (attributes) must be a hash in `AmzSpApi::FulfillmentInboundApiModel20240320::PackingOption` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `AmzSpApi::FulfillmentInboundApiModel20240320::PackingOption`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'discounts')
        if (value = attributes[:'discounts']).is_a?(Array)
          self.discounts = value
        end
      end

      if attributes.key?(:'expiration')
        self.expiration = attributes[:'expiration']
      end

      if attributes.key?(:'fees')
        if (value = attributes[:'fees']).is_a?(Array)
          self.fees = value
        end
      end

      if attributes.key?(:'packing_groups')
        if (value = attributes[:'packing_groups']).is_a?(Array)
          self.packing_groups = value
        end
      end

      if attributes.key?(:'packing_option_id')
        self.packing_option_id = attributes[:'packing_option_id']
      end

      if attributes.key?(:'status')
        self.status = attributes[:'status']
      end

      if attributes.key?(:'supported_shipping_configurations')
        if (value = attributes[:'supported_shipping_configurations']).is_a?(Array)
          self.supported_shipping_configurations = value
        end
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @discounts.nil?
        invalid_properties.push('invalid value for "discounts", discounts cannot be nil.')
      end

      if @fees.nil?
        invalid_properties.push('invalid value for "fees", fees cannot be nil.')
      end

      if @packing_groups.nil?
        invalid_properties.push('invalid value for "packing_groups", packing_groups cannot be nil.')
      end

      if @packing_option_id.nil?
        invalid_properties.push('invalid value for "packing_option_id", packing_option_id cannot be nil.')
      end

      if @status.nil?
        invalid_properties.push('invalid value for "status", status cannot be nil.')
      end

      if @supported_shipping_configurations.nil?
        invalid_properties.push('invalid value for "supported_shipping_configurations", supported_shipping_configurations cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @discounts.nil?
      return false if @fees.nil?
      return false if @packing_groups.nil?
      return false if @packing_option_id.nil?
      return false if @status.nil?
      return false if @supported_shipping_configurations.nil?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          discounts == o.discounts &&
          expiration == o.expiration &&
          fees == o.fees &&
          packing_groups == o.packing_groups &&
          packing_option_id == o.packing_option_id &&
          status == o.status &&
          supported_shipping_configurations == o.supported_shipping_configurations
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [discounts, expiration, fees, packing_groups, packing_option_id, status, supported_shipping_configurations].hash
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
        AmzSpApi::FulfillmentInboundApiModel20240320.const_get(type).build_from_hash(value)
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
