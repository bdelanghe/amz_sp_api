=begin
#Amazon Shipping API

#The Amazon Shipping API is designed to support outbound shipping use cases both for orders originating on Amazon-owned marketplaces as well as external channels/marketplaces. With these APIs, you can request shipping rates, create shipments, cancel shipments, and track shipments.

OpenAPI spec version: v2
Contact: swa-api-core@amazon.com
Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::ShippingApiModelV2
  # The payload for the getTracking operation.
  class GetTrackingResult
    attr_accessor :tracking_id

    attr_accessor :alternate_leg_tracking_id

    # A list of tracking events.
    attr_accessor :event_history

    # The date and time by which the shipment is promised to be delivered.
    attr_accessor :promised_delivery_date

    attr_accessor :summary

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'tracking_id' => :'trackingId',
        :'alternate_leg_tracking_id' => :'alternateLegTrackingId',
        :'event_history' => :'eventHistory',
        :'promised_delivery_date' => :'promisedDeliveryDate',
        :'summary' => :'summary'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'tracking_id' => :'Object',
        :'alternate_leg_tracking_id' => :'Object',
        :'event_history' => :'Object',
        :'promised_delivery_date' => :'Object',
        :'summary' => :'Object'
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
        fail ArgumentError, "The input argument (attributes) must be a hash in `AmzSpApi::ShippingApiModelV2::GetTrackingResult` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `AmzSpApi::ShippingApiModelV2::GetTrackingResult`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'tracking_id')
        self.tracking_id = attributes[:'tracking_id']
      end

      if attributes.key?(:'alternate_leg_tracking_id')
        self.alternate_leg_tracking_id = attributes[:'alternate_leg_tracking_id']
      end

      if attributes.key?(:'event_history')
        if (value = attributes[:'event_history']).is_a?(Array)
          self.event_history = value
        end
      end

      if attributes.key?(:'promised_delivery_date')
        self.promised_delivery_date = attributes[:'promised_delivery_date']
      end

      if attributes.key?(:'summary')
        self.summary = attributes[:'summary']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @tracking_id.nil?
        invalid_properties.push('invalid value for "tracking_id", tracking_id cannot be nil.')
      end

      if @alternate_leg_tracking_id.nil?
        invalid_properties.push('invalid value for "alternate_leg_tracking_id", alternate_leg_tracking_id cannot be nil.')
      end

      if @event_history.nil?
        invalid_properties.push('invalid value for "event_history", event_history cannot be nil.')
      end

      if @promised_delivery_date.nil?
        invalid_properties.push('invalid value for "promised_delivery_date", promised_delivery_date cannot be nil.')
      end

      if @summary.nil?
        invalid_properties.push('invalid value for "summary", summary cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @tracking_id.nil?
      return false if @alternate_leg_tracking_id.nil?
      return false if @event_history.nil?
      return false if @promised_delivery_date.nil?
      return false if @summary.nil?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          tracking_id == o.tracking_id &&
          alternate_leg_tracking_id == o.alternate_leg_tracking_id &&
          event_history == o.event_history &&
          promised_delivery_date == o.promised_delivery_date &&
          summary == o.summary
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [tracking_id, alternate_leg_tracking_id, event_history, promised_delivery_date, summary].hash
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
        AmzSpApi::ShippingApiModelV2.const_get(type).build_from_hash(value)
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
