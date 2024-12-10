=begin
#Selling Partner API for Fulfillment Inbound

#The Selling Partner API for Fulfillment Inbound lets you create applications that create and update inbound shipments of inventory to Amazon's fulfillment network.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::FulfillmentInboundApiModelV0
  # Inbound shipment information used to create and update inbound shipments.
  class InboundShipmentHeader
    # The name for the shipment. Use a naming convention that helps distinguish between shipments over time, such as the date the shipment was created.
    attr_accessor :shipment_name

    attr_accessor :ship_from_address

    # The identifier for the fulfillment center to which the shipment will be shipped. Get this value from the InboundShipmentPlan object in the response returned by the createInboundShipmentPlan operation.
    attr_accessor :destination_fulfillment_center_id

    # Indicates whether or not an inbound shipment contains case-packed boxes. Note: A shipment must contain either all case-packed boxes or all individually packed boxes.  Possible values:  true - All boxes in the shipment must be case packed.  false - All boxes in the shipment must be individually packed.  Note: If AreCasesRequired = true for an inbound shipment, then the value of QuantityInCase must be greater than zero for every item in the shipment. Otherwise the service returns an error.
    attr_accessor :are_cases_required

    attr_accessor :shipment_status

    attr_accessor :label_prep_preference

    attr_accessor :intended_box_contents_source

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'shipment_name' => :'ShipmentName',
        :'ship_from_address' => :'ShipFromAddress',
        :'destination_fulfillment_center_id' => :'DestinationFulfillmentCenterId',
        :'are_cases_required' => :'AreCasesRequired',
        :'shipment_status' => :'ShipmentStatus',
        :'label_prep_preference' => :'LabelPrepPreference',
        :'intended_box_contents_source' => :'IntendedBoxContentsSource'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'shipment_name' => :'Object',
        :'ship_from_address' => :'Object',
        :'destination_fulfillment_center_id' => :'Object',
        :'are_cases_required' => :'Object',
        :'shipment_status' => :'Object',
        :'label_prep_preference' => :'Object',
        :'intended_box_contents_source' => :'Object'
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
        fail ArgumentError, "The input argument (attributes) must be a hash in `AmzSpApi::FulfillmentInboundApiModelV0::InboundShipmentHeader` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `AmzSpApi::FulfillmentInboundApiModelV0::InboundShipmentHeader`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'shipment_name')
        self.shipment_name = attributes[:'shipment_name']
      end

      if attributes.key?(:'ship_from_address')
        self.ship_from_address = attributes[:'ship_from_address']
      end

      if attributes.key?(:'destination_fulfillment_center_id')
        self.destination_fulfillment_center_id = attributes[:'destination_fulfillment_center_id']
      end

      if attributes.key?(:'are_cases_required')
        self.are_cases_required = attributes[:'are_cases_required']
      end

      if attributes.key?(:'shipment_status')
        self.shipment_status = attributes[:'shipment_status']
      end

      if attributes.key?(:'label_prep_preference')
        self.label_prep_preference = attributes[:'label_prep_preference']
      end

      if attributes.key?(:'intended_box_contents_source')
        self.intended_box_contents_source = attributes[:'intended_box_contents_source']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @shipment_name.nil?
        invalid_properties.push('invalid value for "shipment_name", shipment_name cannot be nil.')
      end

      if @ship_from_address.nil?
        invalid_properties.push('invalid value for "ship_from_address", ship_from_address cannot be nil.')
      end

      if @destination_fulfillment_center_id.nil?
        invalid_properties.push('invalid value for "destination_fulfillment_center_id", destination_fulfillment_center_id cannot be nil.')
      end

      if @shipment_status.nil?
        invalid_properties.push('invalid value for "shipment_status", shipment_status cannot be nil.')
      end

      if @label_prep_preference.nil?
        invalid_properties.push('invalid value for "label_prep_preference", label_prep_preference cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @shipment_name.nil?
      return false if @ship_from_address.nil?
      return false if @destination_fulfillment_center_id.nil?
      return false if @shipment_status.nil?
      return false if @label_prep_preference.nil?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          shipment_name == o.shipment_name &&
          ship_from_address == o.ship_from_address &&
          destination_fulfillment_center_id == o.destination_fulfillment_center_id &&
          are_cases_required == o.are_cases_required &&
          shipment_status == o.shipment_status &&
          label_prep_preference == o.label_prep_preference &&
          intended_box_contents_source == o.intended_box_contents_source
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [shipment_name, ship_from_address, destination_fulfillment_center_id, are_cases_required, shipment_status, label_prep_preference, intended_box_contents_source].hash
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
        AmzSpApi::FulfillmentInboundApiModelV0.const_get(type).build_from_hash(value)
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
