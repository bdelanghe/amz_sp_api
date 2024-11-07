=begin
#Vendor Shipments v1

#The Selling Partner API for Retail Procurement Shipments provides programmatic access to retail shipping data for vendors.

OpenAPI spec version: v1

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::VendorShipmentsApiModel
  # A list of one or more shipment confirmations.
  class ShipmentConfirmation
    # Unique shipment ID (not used over the last 365 days).
    attr_accessor :shipment_identifier

    # Indicates if this shipment confirmation is the initial confirmation, or intended to replace an already posted shipment confirmation. If replacing an existing shipment confirmation, be sure to provide the identical shipmentIdentifier and sellingParty information as in the previous confirmation.
    attr_accessor :shipment_confirmation_type

    # The type of shipment.
    attr_accessor :shipment_type

    # Shipment hierarchical structure.
    attr_accessor :shipment_structure

    attr_accessor :transportation_details

    # The Amazon Reference Number is a unique identifier generated by Amazon for all Collect/WePay shipments when you submit  a routing request. This field is mandatory for Collect/WePay shipments.
    attr_accessor :amazon_reference_number

    # Date on which the shipment confirmation was submitted.
    attr_accessor :shipment_confirmation_date

    # The date and time of the departure of the shipment from the vendor's location. Vendors are requested to send ASNs within 30 minutes of departure from their warehouse/distribution center or at least 6 hours prior to the appointment time at the buyer destination warehouse, whichever is sooner. Shipped date mentioned in the shipment confirmation should not be in the future.
    attr_accessor :shipped_date

    # The date and time on which the shipment is estimated to reach buyer's warehouse. It needs to be an estimate based on the average transit time between ship from location and the destination. The exact appointment time will be provided by the buyer and is potentially not known when creating the shipment confirmation.
    attr_accessor :estimated_delivery_date

    attr_accessor :selling_party

    attr_accessor :ship_from_party

    attr_accessor :ship_to_party

    attr_accessor :shipment_measurements

    attr_accessor :import_details

    # A list of the items in this shipment and their associated details. If any of the item detail fields are common at a carton or a pallet level, provide them at the corresponding carton or pallet level.
    attr_accessor :shipped_items

    # A list of the cartons in this shipment.
    attr_accessor :cartons

    # A list of the pallets in this shipment.
    attr_accessor :pallets

    class EnumAttributeValidator
      attr_reader :datatype
      attr_reader :allowable_values

      def initialize(datatype, allowable_values)
        @allowable_values = allowable_values.map do |value|
          case datatype.to_s
          when /Integer/i
            value.to_i
          when /Float/i
            value.to_f
          else
            value
          end
        end
      end

      def valid?(value)
        !value || allowable_values.include?(value)
      end
    end

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'shipment_identifier' => :'shipmentIdentifier',
        :'shipment_confirmation_type' => :'shipmentConfirmationType',
        :'shipment_type' => :'shipmentType',
        :'shipment_structure' => :'shipmentStructure',
        :'transportation_details' => :'transportationDetails',
        :'amazon_reference_number' => :'amazonReferenceNumber',
        :'shipment_confirmation_date' => :'shipmentConfirmationDate',
        :'shipped_date' => :'shippedDate',
        :'estimated_delivery_date' => :'estimatedDeliveryDate',
        :'selling_party' => :'sellingParty',
        :'ship_from_party' => :'shipFromParty',
        :'ship_to_party' => :'shipToParty',
        :'shipment_measurements' => :'shipmentMeasurements',
        :'import_details' => :'importDetails',
        :'shipped_items' => :'shippedItems',
        :'cartons' => :'cartons',
        :'pallets' => :'pallets'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'shipment_identifier' => :'Object',
        :'shipment_confirmation_type' => :'Object',
        :'shipment_type' => :'Object',
        :'shipment_structure' => :'Object',
        :'transportation_details' => :'Object',
        :'amazon_reference_number' => :'Object',
        :'shipment_confirmation_date' => :'Object',
        :'shipped_date' => :'Object',
        :'estimated_delivery_date' => :'Object',
        :'selling_party' => :'Object',
        :'ship_from_party' => :'Object',
        :'ship_to_party' => :'Object',
        :'shipment_measurements' => :'Object',
        :'import_details' => :'Object',
        :'shipped_items' => :'Object',
        :'cartons' => :'Object',
        :'pallets' => :'Object'
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
        fail ArgumentError, "The input argument (attributes) must be a hash in `AmzSpApi::VendorShipmentsApiModel::ShipmentConfirmation` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `AmzSpApi::VendorShipmentsApiModel::ShipmentConfirmation`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'shipment_identifier')
        self.shipment_identifier = attributes[:'shipment_identifier']
      end

      if attributes.key?(:'shipment_confirmation_type')
        self.shipment_confirmation_type = attributes[:'shipment_confirmation_type']
      end

      if attributes.key?(:'shipment_type')
        self.shipment_type = attributes[:'shipment_type']
      end

      if attributes.key?(:'shipment_structure')
        self.shipment_structure = attributes[:'shipment_structure']
      end

      if attributes.key?(:'transportation_details')
        self.transportation_details = attributes[:'transportation_details']
      end

      if attributes.key?(:'amazon_reference_number')
        self.amazon_reference_number = attributes[:'amazon_reference_number']
      end

      if attributes.key?(:'shipment_confirmation_date')
        self.shipment_confirmation_date = attributes[:'shipment_confirmation_date']
      end

      if attributes.key?(:'shipped_date')
        self.shipped_date = attributes[:'shipped_date']
      end

      if attributes.key?(:'estimated_delivery_date')
        self.estimated_delivery_date = attributes[:'estimated_delivery_date']
      end

      if attributes.key?(:'selling_party')
        self.selling_party = attributes[:'selling_party']
      end

      if attributes.key?(:'ship_from_party')
        self.ship_from_party = attributes[:'ship_from_party']
      end

      if attributes.key?(:'ship_to_party')
        self.ship_to_party = attributes[:'ship_to_party']
      end

      if attributes.key?(:'shipment_measurements')
        self.shipment_measurements = attributes[:'shipment_measurements']
      end

      if attributes.key?(:'import_details')
        self.import_details = attributes[:'import_details']
      end

      if attributes.key?(:'shipped_items')
        if (value = attributes[:'shipped_items']).is_a?(Array)
          self.shipped_items = value
        end
      end

      if attributes.key?(:'cartons')
        if (value = attributes[:'cartons']).is_a?(Array)
          self.cartons = value
        end
      end

      if attributes.key?(:'pallets')
        if (value = attributes[:'pallets']).is_a?(Array)
          self.pallets = value
        end
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @shipment_identifier.nil?
        invalid_properties.push('invalid value for "shipment_identifier", shipment_identifier cannot be nil.')
      end

      if @shipment_confirmation_type.nil?
        invalid_properties.push('invalid value for "shipment_confirmation_type", shipment_confirmation_type cannot be nil.')
      end

      if @shipment_confirmation_date.nil?
        invalid_properties.push('invalid value for "shipment_confirmation_date", shipment_confirmation_date cannot be nil.')
      end

      if @selling_party.nil?
        invalid_properties.push('invalid value for "selling_party", selling_party cannot be nil.')
      end

      if @ship_from_party.nil?
        invalid_properties.push('invalid value for "ship_from_party", ship_from_party cannot be nil.')
      end

      if @ship_to_party.nil?
        invalid_properties.push('invalid value for "ship_to_party", ship_to_party cannot be nil.')
      end

      if @shipped_items.nil?
        invalid_properties.push('invalid value for "shipped_items", shipped_items cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @shipment_identifier.nil?
      return false if @shipment_confirmation_type.nil?
      shipment_confirmation_type_validator = EnumAttributeValidator.new('Object', ['Original', 'Replace'])
      return false unless shipment_confirmation_type_validator.valid?(@shipment_confirmation_type)
      shipment_type_validator = EnumAttributeValidator.new('Object', ['TruckLoad', 'LessThanTruckLoad', 'SmallParcel'])
      return false unless shipment_type_validator.valid?(@shipment_type)
      shipment_structure_validator = EnumAttributeValidator.new('Object', ['PalletizedAssortmentCase', 'LooseAssortmentCase', 'PalletOfItems', 'PalletizedStandardCase', 'LooseStandardCase', 'MasterPallet', 'MasterCase'])
      return false unless shipment_structure_validator.valid?(@shipment_structure)
      return false if @shipment_confirmation_date.nil?
      return false if @selling_party.nil?
      return false if @ship_from_party.nil?
      return false if @ship_to_party.nil?
      return false if @shipped_items.nil?
      true
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] shipment_confirmation_type Object to be assigned
    def shipment_confirmation_type=(shipment_confirmation_type)
      validator = EnumAttributeValidator.new('Object', ['Original', 'Replace'])
      unless validator.valid?(shipment_confirmation_type)
        fail ArgumentError, "invalid value for \"shipment_confirmation_type\", must be one of #{validator.allowable_values}."
      end
      @shipment_confirmation_type = shipment_confirmation_type
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] shipment_type Object to be assigned
    def shipment_type=(shipment_type)
      validator = EnumAttributeValidator.new('Object', ['TruckLoad', 'LessThanTruckLoad', 'SmallParcel'])
      unless validator.valid?(shipment_type)
        fail ArgumentError, "invalid value for \"shipment_type\", must be one of #{validator.allowable_values}."
      end
      @shipment_type = shipment_type
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] shipment_structure Object to be assigned
    def shipment_structure=(shipment_structure)
      validator = EnumAttributeValidator.new('Object', ['PalletizedAssortmentCase', 'LooseAssortmentCase', 'PalletOfItems', 'PalletizedStandardCase', 'LooseStandardCase', 'MasterPallet', 'MasterCase'])
      unless validator.valid?(shipment_structure)
        fail ArgumentError, "invalid value for \"shipment_structure\", must be one of #{validator.allowable_values}."
      end
      @shipment_structure = shipment_structure
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          shipment_identifier == o.shipment_identifier &&
          shipment_confirmation_type == o.shipment_confirmation_type &&
          shipment_type == o.shipment_type &&
          shipment_structure == o.shipment_structure &&
          transportation_details == o.transportation_details &&
          amazon_reference_number == o.amazon_reference_number &&
          shipment_confirmation_date == o.shipment_confirmation_date &&
          shipped_date == o.shipped_date &&
          estimated_delivery_date == o.estimated_delivery_date &&
          selling_party == o.selling_party &&
          ship_from_party == o.ship_from_party &&
          ship_to_party == o.ship_to_party &&
          shipment_measurements == o.shipment_measurements &&
          import_details == o.import_details &&
          shipped_items == o.shipped_items &&
          cartons == o.cartons &&
          pallets == o.pallets
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [shipment_identifier, shipment_confirmation_type, shipment_type, shipment_structure, transportation_details, amazon_reference_number, shipment_confirmation_date, shipped_date, estimated_delivery_date, selling_party, ship_from_party, ship_to_party, shipment_measurements, import_details, shipped_items, cartons, pallets].hash
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
        AmzSpApi::VendorShipmentsApiModel.const_get(type).build_from_hash(value)
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
