=begin
#Selling Partner API for Direct Fulfillment Orders

#The Selling Partner API for Direct Fulfillment Orders provides programmatic access to a direct fulfillment vendor's order data.

OpenAPI spec version: 2021-12-28

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::VendorDirectFulfillmentOrdersApiModel20211228
  # Details of an individual order being acknowledged.
  class OrderAcknowledgementItem
    # The purchase order number for this order. Formatting Notes: alpha-numeric code.
    attr_accessor :purchase_order_number

    # The vendor's order number for this order.
    attr_accessor :vendor_order_number

    # The date and time when the order is acknowledged, in ISO-8601 date/time format. For example: 2018-07-16T23:00:00Z / 2018-07-16T23:00:00-05:00 / 2018-07-16T23:00:00-08:00.
    attr_accessor :acknowledgement_date

    attr_accessor :acknowledgement_status

    attr_accessor :selling_party

    attr_accessor :ship_from_party

    # Item details including acknowledged quantity.
    attr_accessor :item_acknowledgements

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'purchase_order_number' => :'purchaseOrderNumber',
        :'vendor_order_number' => :'vendorOrderNumber',
        :'acknowledgement_date' => :'acknowledgementDate',
        :'acknowledgement_status' => :'acknowledgementStatus',
        :'selling_party' => :'sellingParty',
        :'ship_from_party' => :'shipFromParty',
        :'item_acknowledgements' => :'itemAcknowledgements'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'purchase_order_number' => :'Object',
        :'vendor_order_number' => :'Object',
        :'acknowledgement_date' => :'Object',
        :'acknowledgement_status' => :'Object',
        :'selling_party' => :'Object',
        :'ship_from_party' => :'Object',
        :'item_acknowledgements' => :'Object'
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
        fail ArgumentError, "The input argument (attributes) must be a hash in `AmzSpApi::VendorDirectFulfillmentOrdersApiModel20211228::OrderAcknowledgementItem` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `AmzSpApi::VendorDirectFulfillmentOrdersApiModel20211228::OrderAcknowledgementItem`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'purchase_order_number')
        self.purchase_order_number = attributes[:'purchase_order_number']
      end

      if attributes.key?(:'vendor_order_number')
        self.vendor_order_number = attributes[:'vendor_order_number']
      end

      if attributes.key?(:'acknowledgement_date')
        self.acknowledgement_date = attributes[:'acknowledgement_date']
      end

      if attributes.key?(:'acknowledgement_status')
        self.acknowledgement_status = attributes[:'acknowledgement_status']
      end

      if attributes.key?(:'selling_party')
        self.selling_party = attributes[:'selling_party']
      end

      if attributes.key?(:'ship_from_party')
        self.ship_from_party = attributes[:'ship_from_party']
      end

      if attributes.key?(:'item_acknowledgements')
        if (value = attributes[:'item_acknowledgements']).is_a?(Array)
          self.item_acknowledgements = value
        end
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @purchase_order_number.nil?
        invalid_properties.push('invalid value for "purchase_order_number", purchase_order_number cannot be nil.')
      end

      if @vendor_order_number.nil?
        invalid_properties.push('invalid value for "vendor_order_number", vendor_order_number cannot be nil.')
      end

      if @acknowledgement_date.nil?
        invalid_properties.push('invalid value for "acknowledgement_date", acknowledgement_date cannot be nil.')
      end

      if @acknowledgement_status.nil?
        invalid_properties.push('invalid value for "acknowledgement_status", acknowledgement_status cannot be nil.')
      end

      if @selling_party.nil?
        invalid_properties.push('invalid value for "selling_party", selling_party cannot be nil.')
      end

      if @ship_from_party.nil?
        invalid_properties.push('invalid value for "ship_from_party", ship_from_party cannot be nil.')
      end

      if @item_acknowledgements.nil?
        invalid_properties.push('invalid value for "item_acknowledgements", item_acknowledgements cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @purchase_order_number.nil?
      return false if @vendor_order_number.nil?
      return false if @acknowledgement_date.nil?
      return false if @acknowledgement_status.nil?
      return false if @selling_party.nil?
      return false if @ship_from_party.nil?
      return false if @item_acknowledgements.nil?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          purchase_order_number == o.purchase_order_number &&
          vendor_order_number == o.vendor_order_number &&
          acknowledgement_date == o.acknowledgement_date &&
          acknowledgement_status == o.acknowledgement_status &&
          selling_party == o.selling_party &&
          ship_from_party == o.ship_from_party &&
          item_acknowledgements == o.item_acknowledgements
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [purchase_order_number, vendor_order_number, acknowledgement_date, acknowledgement_status, selling_party, ship_from_party, item_acknowledgements].hash
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
        AmzSpApi::VendorDirectFulfillmentOrdersApiModel20211228.const_get(type).build_from_hash(value)
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
