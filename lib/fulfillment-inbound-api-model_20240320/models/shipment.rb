=begin
#Fulfillment Inbound v2024-03-20

#The Selling Partner API for Fulfillment By Amazon (FBA) Inbound. The FBA Inbound API enables building inbound workflows to create, manage, and send shipments into Amazon's fulfillment network. The API has interoperability with the Send-to-Amazon user interface.

OpenAPI spec version: 2024-03-20

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::FulfillmentInboundApiModel20240320
  # Contains information pertaining to a shipment in an inbound plan.
  class Shipment
    # A unique identifier created by Amazon that identifies this Amazon-partnered, Less Than Truckload/Full Truckload (LTL/FTL) shipment.
    attr_accessor :amazon_reference_id

    attr_accessor :contact_information

    attr_accessor :dates

    attr_accessor :destination

    attr_accessor :freight_information

    # The name of the shipment.
    attr_accessor :name

    # The identifier of a placement option. A placement option represents the shipment splits and destinations of SKUs.
    attr_accessor :placement_option_id

    attr_accessor :selected_delivery_window

    # Identifier of a transportation option. A transportation option represent one option for how to send a shipment.
    attr_accessor :selected_transportation_option_id

    # List of self ship appointment details.
    attr_accessor :self_ship_appointment_details

    # The confirmed shipment ID which shows up on labels (for example, `FBA1234ABCD`).
    attr_accessor :shipment_confirmation_id

    # Identifier of a shipment. A shipment contains the boxes and units being inbounded.
    attr_accessor :shipment_id

    attr_accessor :source

    # The status of a shipment. The state of the shipment will typically start as `UNCONFIRMED`, then transition to `WORKING` after a placement option has been confirmed, and then to `READY_TO_SHIP` once labels are generated.  Possible values: `ABANDONED`, `CANCELLED`, `CHECKED_IN`, `CLOSED`, `DELETED`, `DELIVERED`, `IN_TRANSIT`, `MIXED`, `READY_TO_SHIP`, `RECEIVING`, `SHIPPED`, `UNCONFIRMED`, `WORKING`
    attr_accessor :status

    attr_accessor :tracking_details

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'amazon_reference_id' => :'amazonReferenceId',
        :'contact_information' => :'contactInformation',
        :'dates' => :'dates',
        :'destination' => :'destination',
        :'freight_information' => :'freightInformation',
        :'name' => :'name',
        :'placement_option_id' => :'placementOptionId',
        :'selected_delivery_window' => :'selectedDeliveryWindow',
        :'selected_transportation_option_id' => :'selectedTransportationOptionId',
        :'self_ship_appointment_details' => :'selfShipAppointmentDetails',
        :'shipment_confirmation_id' => :'shipmentConfirmationId',
        :'shipment_id' => :'shipmentId',
        :'source' => :'source',
        :'status' => :'status',
        :'tracking_details' => :'trackingDetails'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'amazon_reference_id' => :'Object',
        :'contact_information' => :'Object',
        :'dates' => :'Object',
        :'destination' => :'Object',
        :'freight_information' => :'Object',
        :'name' => :'Object',
        :'placement_option_id' => :'Object',
        :'selected_delivery_window' => :'Object',
        :'selected_transportation_option_id' => :'Object',
        :'self_ship_appointment_details' => :'Object',
        :'shipment_confirmation_id' => :'Object',
        :'shipment_id' => :'Object',
        :'source' => :'Object',
        :'status' => :'Object',
        :'tracking_details' => :'Object'
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
        fail ArgumentError, "The input argument (attributes) must be a hash in `AmzSpApi::FulfillmentInboundApiModel20240320::Shipment` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `AmzSpApi::FulfillmentInboundApiModel20240320::Shipment`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'amazon_reference_id')
        self.amazon_reference_id = attributes[:'amazon_reference_id']
      end

      if attributes.key?(:'contact_information')
        self.contact_information = attributes[:'contact_information']
      end

      if attributes.key?(:'dates')
        self.dates = attributes[:'dates']
      end

      if attributes.key?(:'destination')
        self.destination = attributes[:'destination']
      end

      if attributes.key?(:'freight_information')
        self.freight_information = attributes[:'freight_information']
      end

      if attributes.key?(:'name')
        self.name = attributes[:'name']
      end

      if attributes.key?(:'placement_option_id')
        self.placement_option_id = attributes[:'placement_option_id']
      end

      if attributes.key?(:'selected_delivery_window')
        self.selected_delivery_window = attributes[:'selected_delivery_window']
      end

      if attributes.key?(:'selected_transportation_option_id')
        self.selected_transportation_option_id = attributes[:'selected_transportation_option_id']
      end

      if attributes.key?(:'self_ship_appointment_details')
        if (value = attributes[:'self_ship_appointment_details']).is_a?(Array)
          self.self_ship_appointment_details = value
        end
      end

      if attributes.key?(:'shipment_confirmation_id')
        self.shipment_confirmation_id = attributes[:'shipment_confirmation_id']
      end

      if attributes.key?(:'shipment_id')
        self.shipment_id = attributes[:'shipment_id']
      end

      if attributes.key?(:'source')
        self.source = attributes[:'source']
      end

      if attributes.key?(:'status')
        self.status = attributes[:'status']
      end

      if attributes.key?(:'tracking_details')
        self.tracking_details = attributes[:'tracking_details']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @destination.nil?
        invalid_properties.push('invalid value for "destination", destination cannot be nil.')
      end

      if @placement_option_id.nil?
        invalid_properties.push('invalid value for "placement_option_id", placement_option_id cannot be nil.')
      end

      if @shipment_id.nil?
        invalid_properties.push('invalid value for "shipment_id", shipment_id cannot be nil.')
      end

      if @source.nil?
        invalid_properties.push('invalid value for "source", source cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @destination.nil?
      return false if @placement_option_id.nil?
      return false if @shipment_id.nil?
      return false if @source.nil?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          amazon_reference_id == o.amazon_reference_id &&
          contact_information == o.contact_information &&
          dates == o.dates &&
          destination == o.destination &&
          freight_information == o.freight_information &&
          name == o.name &&
          placement_option_id == o.placement_option_id &&
          selected_delivery_window == o.selected_delivery_window &&
          selected_transportation_option_id == o.selected_transportation_option_id &&
          self_ship_appointment_details == o.self_ship_appointment_details &&
          shipment_confirmation_id == o.shipment_confirmation_id &&
          shipment_id == o.shipment_id &&
          source == o.source &&
          status == o.status &&
          tracking_details == o.tracking_details
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [amazon_reference_id, contact_information, dates, destination, freight_information, name, placement_option_id, selected_delivery_window, selected_transportation_option_id, self_ship_appointment_details, shipment_confirmation_id, shipment_id, source, status, tracking_details].hash
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
