=begin
#Orders v0

#Use the Orders Selling Partner API to programmatically retrieve order information. With this API, you can develop fast, flexible, and custom applications to manage order synchronization, perform order research, and create demand-based decision support tools.   _Note:_ For the JP, AU, and SG marketplaces, the Orders API supports orders from 2016 onward. For all other marketplaces, the Orders API supports orders for the last two years (orders older than this don't show up in the response).

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::OrdersApiModelV0
  # A single order item.
  class OrderItem
    # The item's Amazon Standard Identification Number (ASIN).
    attr_accessor :asin

    # The item's seller stock keeping unit (SKU).
    attr_accessor :seller_sku

    # An Amazon-defined order item identifier.
    attr_accessor :order_item_id

    # A list of associated items that a customer has purchased with a product. For example, a tire installation service purchased with tires.
    attr_accessor :associated_items

    # The item's name.
    attr_accessor :title

    # The number of items in the order. 
    attr_accessor :quantity_ordered

    # The number of items shipped.
    attr_accessor :quantity_shipped

    attr_accessor :product_info

    attr_accessor :points_granted

    attr_accessor :item_price

    attr_accessor :shipping_price

    attr_accessor :item_tax

    attr_accessor :shipping_tax

    attr_accessor :shipping_discount

    attr_accessor :shipping_discount_tax

    attr_accessor :promotion_discount

    attr_accessor :promotion_discount_tax

    attr_accessor :promotion_ids

    attr_accessor :cod_fee

    attr_accessor :cod_fee_discount

    # Indicates whether the item is a gift.  **Possible values**: `true` and `false`.
    attr_accessor :is_gift

    # The condition of the item, as described by the seller.
    attr_accessor :condition_note

    # The condition of the item.  **Possible values**: `New`, `Used`, `Collectible`, `Refurbished`, `Preorder`, and `Club`.
    attr_accessor :condition_id

    # The subcondition of the item.  **Possible values**: `New`, `Mint`, `Very Good`, `Good`, `Acceptable`, `Poor`, `Club`, `OEM`, `Warranty`, `Refurbished Warranty`, `Refurbished`, `Open Box`, `Any`, and `Other`.
    attr_accessor :condition_subtype_id

    # The start date of the scheduled delivery window in the time zone for the order destination. In [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date time format.
    attr_accessor :scheduled_delivery_start_date

    # The end date of the scheduled delivery window in the time zone for the order destination. In [ISO 8601](https://developer-docs.amazon.com/sp-api/docs/iso-8601) date time format.
    attr_accessor :scheduled_delivery_end_date

    # Indicates that the selling price is a special price that is only available for Amazon Business orders. For more information about the Amazon Business Seller Program, refer to the [Amazon Business website](https://www.amazon.com/b2b/info/amazon-business).   **Possible values**: `BusinessPrice`
    attr_accessor :price_designation

    attr_accessor :tax_collection

    # When true, the product type for this item has a serial number.   Only returned for Amazon Easy Ship orders.
    attr_accessor :serial_number_required

    # When true, the ASIN is enrolled in Transparency. The Transparency serial number that you must submit is determined by:  **1D or 2D Barcode:** This has a **T** logo. Submit either the 29-character alpha-numeric identifier beginning with **AZ** or **ZA**, or the 38-character Serialized Global Trade Item Number (SGTIN). **2D Barcode SN:** Submit the 7- to 20-character serial number barcode, which likely has the prefix **SN**. The serial number is applied to the same side of the packaging as the GTIN (UPC/EAN/ISBN) barcode. **QR code SN:** Submit the URL that the QR code generates.
    attr_accessor :is_transparency

    # The IOSS number of the marketplace. Sellers shipping to the EU from outside the EU must provide this IOSS number to their carrier when Amazon has collected the VAT on the sale.
    attr_accessor :ioss_number

    # The store chain store identifier. Linked to a specific store in a store chain.
    attr_accessor :store_chain_store_id

    # The category of deemed reseller. This applies to selling partners that are not based in the EU and is used to help them meet the VAT Deemed Reseller tax laws in the EU and UK.
    attr_accessor :deemed_reseller_category

    attr_accessor :buyer_info

    attr_accessor :buyer_requested_cancel

    # A list of serial numbers for electronic products that are shipped to customers. Returned for FBA orders only.
    attr_accessor :serial_numbers

    attr_accessor :substitution_preferences

    attr_accessor :measurement

    attr_accessor :shipping_constraints

    attr_accessor :amazon_programs

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
        :'asin' => :'ASIN',
        :'seller_sku' => :'SellerSKU',
        :'order_item_id' => :'OrderItemId',
        :'associated_items' => :'AssociatedItems',
        :'title' => :'Title',
        :'quantity_ordered' => :'QuantityOrdered',
        :'quantity_shipped' => :'QuantityShipped',
        :'product_info' => :'ProductInfo',
        :'points_granted' => :'PointsGranted',
        :'item_price' => :'ItemPrice',
        :'shipping_price' => :'ShippingPrice',
        :'item_tax' => :'ItemTax',
        :'shipping_tax' => :'ShippingTax',
        :'shipping_discount' => :'ShippingDiscount',
        :'shipping_discount_tax' => :'ShippingDiscountTax',
        :'promotion_discount' => :'PromotionDiscount',
        :'promotion_discount_tax' => :'PromotionDiscountTax',
        :'promotion_ids' => :'PromotionIds',
        :'cod_fee' => :'CODFee',
        :'cod_fee_discount' => :'CODFeeDiscount',
        :'is_gift' => :'IsGift',
        :'condition_note' => :'ConditionNote',
        :'condition_id' => :'ConditionId',
        :'condition_subtype_id' => :'ConditionSubtypeId',
        :'scheduled_delivery_start_date' => :'ScheduledDeliveryStartDate',
        :'scheduled_delivery_end_date' => :'ScheduledDeliveryEndDate',
        :'price_designation' => :'PriceDesignation',
        :'tax_collection' => :'TaxCollection',
        :'serial_number_required' => :'SerialNumberRequired',
        :'is_transparency' => :'IsTransparency',
        :'ioss_number' => :'IossNumber',
        :'store_chain_store_id' => :'StoreChainStoreId',
        :'deemed_reseller_category' => :'DeemedResellerCategory',
        :'buyer_info' => :'BuyerInfo',
        :'buyer_requested_cancel' => :'BuyerRequestedCancel',
        :'serial_numbers' => :'SerialNumbers',
        :'substitution_preferences' => :'SubstitutionPreferences',
        :'measurement' => :'Measurement',
        :'shipping_constraints' => :'ShippingConstraints',
        :'amazon_programs' => :'AmazonPrograms'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'asin' => :'Object',
        :'seller_sku' => :'Object',
        :'order_item_id' => :'Object',
        :'associated_items' => :'Object',
        :'title' => :'Object',
        :'quantity_ordered' => :'Object',
        :'quantity_shipped' => :'Object',
        :'product_info' => :'Object',
        :'points_granted' => :'Object',
        :'item_price' => :'Object',
        :'shipping_price' => :'Object',
        :'item_tax' => :'Object',
        :'shipping_tax' => :'Object',
        :'shipping_discount' => :'Object',
        :'shipping_discount_tax' => :'Object',
        :'promotion_discount' => :'Object',
        :'promotion_discount_tax' => :'Object',
        :'promotion_ids' => :'Object',
        :'cod_fee' => :'Object',
        :'cod_fee_discount' => :'Object',
        :'is_gift' => :'Object',
        :'condition_note' => :'Object',
        :'condition_id' => :'Object',
        :'condition_subtype_id' => :'Object',
        :'scheduled_delivery_start_date' => :'Object',
        :'scheduled_delivery_end_date' => :'Object',
        :'price_designation' => :'Object',
        :'tax_collection' => :'Object',
        :'serial_number_required' => :'Object',
        :'is_transparency' => :'Object',
        :'ioss_number' => :'Object',
        :'store_chain_store_id' => :'Object',
        :'deemed_reseller_category' => :'Object',
        :'buyer_info' => :'Object',
        :'buyer_requested_cancel' => :'Object',
        :'serial_numbers' => :'Object',
        :'substitution_preferences' => :'Object',
        :'measurement' => :'Object',
        :'shipping_constraints' => :'Object',
        :'amazon_programs' => :'Object'
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
        fail ArgumentError, "The input argument (attributes) must be a hash in `AmzSpApi::OrdersApiModelV0::OrderItem` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `AmzSpApi::OrdersApiModelV0::OrderItem`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'asin')
        self.asin = attributes[:'asin']
      end

      if attributes.key?(:'seller_sku')
        self.seller_sku = attributes[:'seller_sku']
      end

      if attributes.key?(:'order_item_id')
        self.order_item_id = attributes[:'order_item_id']
      end

      if attributes.key?(:'associated_items')
        if (value = attributes[:'associated_items']).is_a?(Array)
          self.associated_items = value
        end
      end

      if attributes.key?(:'title')
        self.title = attributes[:'title']
      end

      if attributes.key?(:'quantity_ordered')
        self.quantity_ordered = attributes[:'quantity_ordered']
      end

      if attributes.key?(:'quantity_shipped')
        self.quantity_shipped = attributes[:'quantity_shipped']
      end

      if attributes.key?(:'product_info')
        self.product_info = attributes[:'product_info']
      end

      if attributes.key?(:'points_granted')
        self.points_granted = attributes[:'points_granted']
      end

      if attributes.key?(:'item_price')
        self.item_price = attributes[:'item_price']
      end

      if attributes.key?(:'shipping_price')
        self.shipping_price = attributes[:'shipping_price']
      end

      if attributes.key?(:'item_tax')
        self.item_tax = attributes[:'item_tax']
      end

      if attributes.key?(:'shipping_tax')
        self.shipping_tax = attributes[:'shipping_tax']
      end

      if attributes.key?(:'shipping_discount')
        self.shipping_discount = attributes[:'shipping_discount']
      end

      if attributes.key?(:'shipping_discount_tax')
        self.shipping_discount_tax = attributes[:'shipping_discount_tax']
      end

      if attributes.key?(:'promotion_discount')
        self.promotion_discount = attributes[:'promotion_discount']
      end

      if attributes.key?(:'promotion_discount_tax')
        self.promotion_discount_tax = attributes[:'promotion_discount_tax']
      end

      if attributes.key?(:'promotion_ids')
        self.promotion_ids = attributes[:'promotion_ids']
      end

      if attributes.key?(:'cod_fee')
        self.cod_fee = attributes[:'cod_fee']
      end

      if attributes.key?(:'cod_fee_discount')
        self.cod_fee_discount = attributes[:'cod_fee_discount']
      end

      if attributes.key?(:'is_gift')
        self.is_gift = attributes[:'is_gift']
      end

      if attributes.key?(:'condition_note')
        self.condition_note = attributes[:'condition_note']
      end

      if attributes.key?(:'condition_id')
        self.condition_id = attributes[:'condition_id']
      end

      if attributes.key?(:'condition_subtype_id')
        self.condition_subtype_id = attributes[:'condition_subtype_id']
      end

      if attributes.key?(:'scheduled_delivery_start_date')
        self.scheduled_delivery_start_date = attributes[:'scheduled_delivery_start_date']
      end

      if attributes.key?(:'scheduled_delivery_end_date')
        self.scheduled_delivery_end_date = attributes[:'scheduled_delivery_end_date']
      end

      if attributes.key?(:'price_designation')
        self.price_designation = attributes[:'price_designation']
      end

      if attributes.key?(:'tax_collection')
        self.tax_collection = attributes[:'tax_collection']
      end

      if attributes.key?(:'serial_number_required')
        self.serial_number_required = attributes[:'serial_number_required']
      end

      if attributes.key?(:'is_transparency')
        self.is_transparency = attributes[:'is_transparency']
      end

      if attributes.key?(:'ioss_number')
        self.ioss_number = attributes[:'ioss_number']
      end

      if attributes.key?(:'store_chain_store_id')
        self.store_chain_store_id = attributes[:'store_chain_store_id']
      end

      if attributes.key?(:'deemed_reseller_category')
        self.deemed_reseller_category = attributes[:'deemed_reseller_category']
      end

      if attributes.key?(:'buyer_info')
        self.buyer_info = attributes[:'buyer_info']
      end

      if attributes.key?(:'buyer_requested_cancel')
        self.buyer_requested_cancel = attributes[:'buyer_requested_cancel']
      end

      if attributes.key?(:'serial_numbers')
        if (value = attributes[:'serial_numbers']).is_a?(Array)
          self.serial_numbers = value
        end
      end

      if attributes.key?(:'substitution_preferences')
        self.substitution_preferences = attributes[:'substitution_preferences']
      end

      if attributes.key?(:'measurement')
        self.measurement = attributes[:'measurement']
      end

      if attributes.key?(:'shipping_constraints')
        self.shipping_constraints = attributes[:'shipping_constraints']
      end

      if attributes.key?(:'amazon_programs')
        self.amazon_programs = attributes[:'amazon_programs']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @asin.nil?
        invalid_properties.push('invalid value for "asin", asin cannot be nil.')
      end

      if @order_item_id.nil?
        invalid_properties.push('invalid value for "order_item_id", order_item_id cannot be nil.')
      end

      if @quantity_ordered.nil?
        invalid_properties.push('invalid value for "quantity_ordered", quantity_ordered cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @asin.nil?
      return false if @order_item_id.nil?
      return false if @quantity_ordered.nil?
      deemed_reseller_category_validator = EnumAttributeValidator.new('Object', ['IOSS', 'UOSS'])
      return false unless deemed_reseller_category_validator.valid?(@deemed_reseller_category)
      true
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] deemed_reseller_category Object to be assigned
    def deemed_reseller_category=(deemed_reseller_category)
      validator = EnumAttributeValidator.new('Object', ['IOSS', 'UOSS'])
      unless validator.valid?(deemed_reseller_category)
        fail ArgumentError, "invalid value for \"deemed_reseller_category\", must be one of #{validator.allowable_values}."
      end
      @deemed_reseller_category = deemed_reseller_category
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          asin == o.asin &&
          seller_sku == o.seller_sku &&
          order_item_id == o.order_item_id &&
          associated_items == o.associated_items &&
          title == o.title &&
          quantity_ordered == o.quantity_ordered &&
          quantity_shipped == o.quantity_shipped &&
          product_info == o.product_info &&
          points_granted == o.points_granted &&
          item_price == o.item_price &&
          shipping_price == o.shipping_price &&
          item_tax == o.item_tax &&
          shipping_tax == o.shipping_tax &&
          shipping_discount == o.shipping_discount &&
          shipping_discount_tax == o.shipping_discount_tax &&
          promotion_discount == o.promotion_discount &&
          promotion_discount_tax == o.promotion_discount_tax &&
          promotion_ids == o.promotion_ids &&
          cod_fee == o.cod_fee &&
          cod_fee_discount == o.cod_fee_discount &&
          is_gift == o.is_gift &&
          condition_note == o.condition_note &&
          condition_id == o.condition_id &&
          condition_subtype_id == o.condition_subtype_id &&
          scheduled_delivery_start_date == o.scheduled_delivery_start_date &&
          scheduled_delivery_end_date == o.scheduled_delivery_end_date &&
          price_designation == o.price_designation &&
          tax_collection == o.tax_collection &&
          serial_number_required == o.serial_number_required &&
          is_transparency == o.is_transparency &&
          ioss_number == o.ioss_number &&
          store_chain_store_id == o.store_chain_store_id &&
          deemed_reseller_category == o.deemed_reseller_category &&
          buyer_info == o.buyer_info &&
          buyer_requested_cancel == o.buyer_requested_cancel &&
          serial_numbers == o.serial_numbers &&
          substitution_preferences == o.substitution_preferences &&
          measurement == o.measurement &&
          shipping_constraints == o.shipping_constraints &&
          amazon_programs == o.amazon_programs
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [asin, seller_sku, order_item_id, associated_items, title, quantity_ordered, quantity_shipped, product_info, points_granted, item_price, shipping_price, item_tax, shipping_tax, shipping_discount, shipping_discount_tax, promotion_discount, promotion_discount_tax, promotion_ids, cod_fee, cod_fee_discount, is_gift, condition_note, condition_id, condition_subtype_id, scheduled_delivery_start_date, scheduled_delivery_end_date, price_designation, tax_collection, serial_number_required, is_transparency, ioss_number, store_chain_store_id, deemed_reseller_category, buyer_info, buyer_requested_cancel, serial_numbers, substitution_preferences, measurement, shipping_constraints, amazon_programs].hash
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
        AmzSpApi::OrdersApiModelV0.const_get(type).build_from_hash(value)
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
