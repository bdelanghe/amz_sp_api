=begin
#Selling Partner API for Direct Fulfillment Orders

#The Selling Partner API for Direct Fulfillment Orders provides programmatic access to a direct fulfillment vendor's order data.

OpenAPI spec version: 2021-12-28

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::VendorDirectFulfillmentOrdersApiModel20211228
  # An item within an order
  class OrderItem
    # Numbering of the item on the purchase order. The first item will be 1, the second 2, and so on.
    attr_accessor :item_sequence_number

    # Buyer's standard identification number (ASIN) of an item.
    attr_accessor :buyer_product_identifier

    # The vendor selected product identification of the item.
    attr_accessor :vendor_product_identifier

    # Title for the item.
    attr_accessor :title

    attr_accessor :ordered_quantity

    attr_accessor :scheduled_delivery_shipment

    attr_accessor :gift_details

    attr_accessor :net_price

    attr_accessor :tax_details

    attr_accessor :total_price

    attr_accessor :buyer_customized_info

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'item_sequence_number' => :'itemSequenceNumber',
        :'buyer_product_identifier' => :'buyerProductIdentifier',
        :'vendor_product_identifier' => :'vendorProductIdentifier',
        :'title' => :'title',
        :'ordered_quantity' => :'orderedQuantity',
        :'scheduled_delivery_shipment' => :'scheduledDeliveryShipment',
        :'gift_details' => :'giftDetails',
        :'net_price' => :'netPrice',
        :'tax_details' => :'taxDetails',
        :'total_price' => :'totalPrice',
        :'buyer_customized_info' => :'buyerCustomizedInfo'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'item_sequence_number' => :'Object',
        :'buyer_product_identifier' => :'Object',
        :'vendor_product_identifier' => :'Object',
        :'title' => :'Object',
        :'ordered_quantity' => :'Object',
        :'scheduled_delivery_shipment' => :'Object',
        :'gift_details' => :'Object',
        :'net_price' => :'Object',
        :'tax_details' => :'Object',
        :'total_price' => :'Object',
        :'buyer_customized_info' => :'Object'
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
        fail ArgumentError, "The input argument (attributes) must be a hash in `AmzSpApi::VendorDirectFulfillmentOrdersApiModel20211228::OrderItem` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `AmzSpApi::VendorDirectFulfillmentOrdersApiModel20211228::OrderItem`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'item_sequence_number')
        self.item_sequence_number = attributes[:'item_sequence_number']
      end

      if attributes.key?(:'buyer_product_identifier')
        self.buyer_product_identifier = attributes[:'buyer_product_identifier']
      end

      if attributes.key?(:'vendor_product_identifier')
        self.vendor_product_identifier = attributes[:'vendor_product_identifier']
      end

      if attributes.key?(:'title')
        self.title = attributes[:'title']
      end

      if attributes.key?(:'ordered_quantity')
        self.ordered_quantity = attributes[:'ordered_quantity']
      end

      if attributes.key?(:'scheduled_delivery_shipment')
        self.scheduled_delivery_shipment = attributes[:'scheduled_delivery_shipment']
      end

      if attributes.key?(:'gift_details')
        self.gift_details = attributes[:'gift_details']
      end

      if attributes.key?(:'net_price')
        self.net_price = attributes[:'net_price']
      end

      if attributes.key?(:'tax_details')
        self.tax_details = attributes[:'tax_details']
      end

      if attributes.key?(:'total_price')
        self.total_price = attributes[:'total_price']
      end

      if attributes.key?(:'buyer_customized_info')
        self.buyer_customized_info = attributes[:'buyer_customized_info']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @item_sequence_number.nil?
        invalid_properties.push('invalid value for "item_sequence_number", item_sequence_number cannot be nil.')
      end

      if @ordered_quantity.nil?
        invalid_properties.push('invalid value for "ordered_quantity", ordered_quantity cannot be nil.')
      end

      if @net_price.nil?
        invalid_properties.push('invalid value for "net_price", net_price cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @item_sequence_number.nil?
      return false if @ordered_quantity.nil?
      return false if @net_price.nil?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          item_sequence_number == o.item_sequence_number &&
          buyer_product_identifier == o.buyer_product_identifier &&
          vendor_product_identifier == o.vendor_product_identifier &&
          title == o.title &&
          ordered_quantity == o.ordered_quantity &&
          scheduled_delivery_shipment == o.scheduled_delivery_shipment &&
          gift_details == o.gift_details &&
          net_price == o.net_price &&
          tax_details == o.tax_details &&
          total_price == o.total_price &&
          buyer_customized_info == o.buyer_customized_info
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [item_sequence_number, buyer_product_identifier, vendor_product_identifier, title, ordered_quantity, scheduled_delivery_shipment, gift_details, net_price, tax_details, total_price, buyer_customized_info].hash
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
