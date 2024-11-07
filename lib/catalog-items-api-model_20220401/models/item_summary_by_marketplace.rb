=begin
#Catalog Items v2022-04-01

#The Selling Partner API for Catalog Items provides programmatic access to information about items in the Amazon catalog.  For more information, refer to the [Catalog Items API Use Case Guide](doc:catalog-items-api-v2022-04-01-use-case-guide).

OpenAPI spec version: 2022-04-01

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::CatalogItemsApiModel20220401
  # Summary details of an Amazon catalog item for the indicated Amazon marketplace.
  class ItemSummaryByMarketplace
    # Amazon marketplace identifier.
    attr_accessor :marketplace_id

    # Identifies an Amazon catalog item is intended for an adult audience or is sexual in nature.
    attr_accessor :adult_product

    # Identifies an Amazon catalog item is autographed by a player or celebrity.
    attr_accessor :autographed

    # Name of the brand associated with an Amazon catalog item.
    attr_accessor :brand

    attr_accessor :browse_classification

    # Name of the color associated with an Amazon catalog item.
    attr_accessor :color

    # Individual contributors to the creation of an item, such as the authors or actors.
    attr_accessor :contributors

    # Classification type associated with the Amazon catalog item.
    attr_accessor :item_classification

    # Name, or title, associated with an Amazon catalog item.
    attr_accessor :item_name

    # Name of the manufacturer associated with an Amazon catalog item.
    attr_accessor :manufacturer

    # Identifies an Amazon catalog item is memorabilia valued for its connection with historical events, culture, or entertainment.
    attr_accessor :memorabilia

    # Model number associated with an Amazon catalog item.
    attr_accessor :model_number

    # Quantity of an Amazon catalog item in one package.
    attr_accessor :package_quantity

    # Part number associated with an Amazon catalog item.
    attr_accessor :part_number

    # First date on which an Amazon catalog item is shippable to customers.
    attr_accessor :release_date

    # Name of the size associated with an Amazon catalog item.
    attr_accessor :size

    # Name of the style associated with an Amazon catalog item.
    attr_accessor :style

    # Identifies an Amazon catalog item is eligible for trade-in.
    attr_accessor :trade_in_eligible

    # Identifier of the website display group associated with an Amazon catalog item.
    attr_accessor :website_display_group

    # Display name of the website display group associated with an Amazon catalog item.
    attr_accessor :website_display_group_name

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
        :'marketplace_id' => :'marketplaceId',
        :'adult_product' => :'adultProduct',
        :'autographed' => :'autographed',
        :'brand' => :'brand',
        :'browse_classification' => :'browseClassification',
        :'color' => :'color',
        :'contributors' => :'contributors',
        :'item_classification' => :'itemClassification',
        :'item_name' => :'itemName',
        :'manufacturer' => :'manufacturer',
        :'memorabilia' => :'memorabilia',
        :'model_number' => :'modelNumber',
        :'package_quantity' => :'packageQuantity',
        :'part_number' => :'partNumber',
        :'release_date' => :'releaseDate',
        :'size' => :'size',
        :'style' => :'style',
        :'trade_in_eligible' => :'tradeInEligible',
        :'website_display_group' => :'websiteDisplayGroup',
        :'website_display_group_name' => :'websiteDisplayGroupName'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'marketplace_id' => :'Object',
        :'adult_product' => :'Object',
        :'autographed' => :'Object',
        :'brand' => :'Object',
        :'browse_classification' => :'Object',
        :'color' => :'Object',
        :'contributors' => :'Object',
        :'item_classification' => :'Object',
        :'item_name' => :'Object',
        :'manufacturer' => :'Object',
        :'memorabilia' => :'Object',
        :'model_number' => :'Object',
        :'package_quantity' => :'Object',
        :'part_number' => :'Object',
        :'release_date' => :'Object',
        :'size' => :'Object',
        :'style' => :'Object',
        :'trade_in_eligible' => :'Object',
        :'website_display_group' => :'Object',
        :'website_display_group_name' => :'Object'
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
        fail ArgumentError, "The input argument (attributes) must be a hash in `AmzSpApi::CatalogItemsApiModel20220401::ItemSummaryByMarketplace` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `AmzSpApi::CatalogItemsApiModel20220401::ItemSummaryByMarketplace`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'marketplace_id')
        self.marketplace_id = attributes[:'marketplace_id']
      end

      if attributes.key?(:'adult_product')
        self.adult_product = attributes[:'adult_product']
      end

      if attributes.key?(:'autographed')
        self.autographed = attributes[:'autographed']
      end

      if attributes.key?(:'brand')
        self.brand = attributes[:'brand']
      end

      if attributes.key?(:'browse_classification')
        self.browse_classification = attributes[:'browse_classification']
      end

      if attributes.key?(:'color')
        self.color = attributes[:'color']
      end

      if attributes.key?(:'contributors')
        if (value = attributes[:'contributors']).is_a?(Array)
          self.contributors = value
        end
      end

      if attributes.key?(:'item_classification')
        self.item_classification = attributes[:'item_classification']
      end

      if attributes.key?(:'item_name')
        self.item_name = attributes[:'item_name']
      end

      if attributes.key?(:'manufacturer')
        self.manufacturer = attributes[:'manufacturer']
      end

      if attributes.key?(:'memorabilia')
        self.memorabilia = attributes[:'memorabilia']
      end

      if attributes.key?(:'model_number')
        self.model_number = attributes[:'model_number']
      end

      if attributes.key?(:'package_quantity')
        self.package_quantity = attributes[:'package_quantity']
      end

      if attributes.key?(:'part_number')
        self.part_number = attributes[:'part_number']
      end

      if attributes.key?(:'release_date')
        self.release_date = attributes[:'release_date']
      end

      if attributes.key?(:'size')
        self.size = attributes[:'size']
      end

      if attributes.key?(:'style')
        self.style = attributes[:'style']
      end

      if attributes.key?(:'trade_in_eligible')
        self.trade_in_eligible = attributes[:'trade_in_eligible']
      end

      if attributes.key?(:'website_display_group')
        self.website_display_group = attributes[:'website_display_group']
      end

      if attributes.key?(:'website_display_group_name')
        self.website_display_group_name = attributes[:'website_display_group_name']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @marketplace_id.nil?
        invalid_properties.push('invalid value for "marketplace_id", marketplace_id cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @marketplace_id.nil?
      item_classification_validator = EnumAttributeValidator.new('Object', ['BASE_PRODUCT', 'OTHER', 'PRODUCT_BUNDLE', 'VARIATION_PARENT'])
      return false unless item_classification_validator.valid?(@item_classification)
      true
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] item_classification Object to be assigned
    def item_classification=(item_classification)
      validator = EnumAttributeValidator.new('Object', ['BASE_PRODUCT', 'OTHER', 'PRODUCT_BUNDLE', 'VARIATION_PARENT'])
      unless validator.valid?(item_classification)
        fail ArgumentError, "invalid value for \"item_classification\", must be one of #{validator.allowable_values}."
      end
      @item_classification = item_classification
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          marketplace_id == o.marketplace_id &&
          adult_product == o.adult_product &&
          autographed == o.autographed &&
          brand == o.brand &&
          browse_classification == o.browse_classification &&
          color == o.color &&
          contributors == o.contributors &&
          item_classification == o.item_classification &&
          item_name == o.item_name &&
          manufacturer == o.manufacturer &&
          memorabilia == o.memorabilia &&
          model_number == o.model_number &&
          package_quantity == o.package_quantity &&
          part_number == o.part_number &&
          release_date == o.release_date &&
          size == o.size &&
          style == o.style &&
          trade_in_eligible == o.trade_in_eligible &&
          website_display_group == o.website_display_group &&
          website_display_group_name == o.website_display_group_name
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [marketplace_id, adult_product, autographed, brand, browse_classification, color, contributors, item_classification, item_name, manufacturer, memorabilia, model_number, package_quantity, part_number, release_date, size, style, trade_in_eligible, website_display_group, website_display_group_name].hash
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
        AmzSpApi::CatalogItemsApiModel20220401.const_get(type).build_from_hash(value)
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
