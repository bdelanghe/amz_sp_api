=begin
#Selling Partner API for Catalog Items

#The Selling Partner API for Catalog Items helps you programmatically retrieve item details for items in the catalog.

OpenAPI spec version: v0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.63
=end

require 'date'

module AmzSpApi::CatalogItemsApiModelV0
  # The attributes of the item.
  class AttributeSetListType
    # The actor attributes of the item.
    attr_accessor :actor

    # The artist attributes of the item.
    attr_accessor :artist

    # The aspect ratio attribute of the item.
    attr_accessor :aspect_ratio

    # The audience rating attribute of the item.
    attr_accessor :audience_rating

    # The author attributes of the item.
    attr_accessor :author

    # The back finding attribute of the item.
    attr_accessor :back_finding

    # The band material type attribute of the item.
    attr_accessor :band_material_type

    # The binding attribute of the item.
    attr_accessor :binding

    # The Bluray region attribute of the item.
    attr_accessor :bluray_region

    # The brand attribute of the item.
    attr_accessor :brand

    # The CERO age rating attribute of the item.
    attr_accessor :cero_age_rating

    # The chain type attribute of the item.
    attr_accessor :chain_type

    # The clasp type attribute of the item.
    attr_accessor :clasp_type

    # The color attribute of the item.
    attr_accessor :color

    # The CPU manufacturer attribute of the item.
    attr_accessor :cpu_manufacturer

    attr_accessor :cpu_speed

    # The CPU type attribute of the item.
    attr_accessor :cpu_type

    # The creator attributes of the item.
    attr_accessor :creator

    # The department attribute of the item.
    attr_accessor :department

    # The director attributes of the item.
    attr_accessor :director

    attr_accessor :display_size

    # The edition attribute of the item.
    attr_accessor :edition

    # The episode sequence attribute of the item.
    attr_accessor :episode_sequence

    # The ESRB age rating attribute of the item.
    attr_accessor :esrb_age_rating

    # The feature attributes of the item
    attr_accessor :feature

    # The flavor attribute of the item.
    attr_accessor :flavor

    # The format attributes of the item.
    attr_accessor :format

    # The gem type attributes of the item.
    attr_accessor :gem_type

    # The genre attribute of the item.
    attr_accessor :genre

    # The golf club flex attribute of the item.
    attr_accessor :golf_club_flex

    attr_accessor :golf_club_loft

    # The hand orientation attribute of the item.
    attr_accessor :hand_orientation

    # The hard disk interface attribute of the item.
    attr_accessor :hard_disk_interface

    attr_accessor :hard_disk_size

    # The hardware platform attribute of the item.
    attr_accessor :hardware_platform

    # The hazardous material type attribute of the item.
    attr_accessor :hazardous_material_type

    attr_accessor :item_dimensions

    # The adult product attribute of the item.
    attr_accessor :is_adult_product

    # The autographed attribute of the item.
    attr_accessor :is_autographed

    # The is eligible for trade in attribute of the item.
    attr_accessor :is_eligible_for_trade_in

    # The is memorabilia attribute of the item.
    attr_accessor :is_memorabilia

    # The issues per year attribute of the item.
    attr_accessor :issues_per_year

    # The item part number attribute of the item.
    attr_accessor :item_part_number

    # The label attribute of the item.
    attr_accessor :label

    # The languages attribute of the item.
    attr_accessor :languages

    # The legal disclaimer attribute of the item.
    attr_accessor :legal_disclaimer

    attr_accessor :list_price

    # The manufacturer attribute of the item.
    attr_accessor :manufacturer

    attr_accessor :manufacturer_maximum_age

    attr_accessor :manufacturer_minimum_age

    # The manufacturer parts warranty description attribute of the item.
    attr_accessor :manufacturer_parts_warranty_description

    # The material type attributes of the item.
    attr_accessor :material_type

    attr_accessor :maximum_resolution

    # The media type attributes of the item.
    attr_accessor :media_type

    # The metal stamp attribute of the item.
    attr_accessor :metal_stamp

    # The metal type attribute of the item.
    attr_accessor :metal_type

    # The model attribute of the item.
    attr_accessor :model

    # The number of discs attribute of the item.
    attr_accessor :number_of_discs

    # The number of issues attribute of the item.
    attr_accessor :number_of_issues

    # The number of items attribute of the item.
    attr_accessor :number_of_items

    # The number of pages attribute of the item.
    attr_accessor :number_of_pages

    # The number of tracks attribute of the item.
    attr_accessor :number_of_tracks

    # The operating system attributes of the item.
    attr_accessor :operating_system

    attr_accessor :optical_zoom

    attr_accessor :package_dimensions

    # The package quantity attribute of the item.
    attr_accessor :package_quantity

    # The part number attribute of the item.
    attr_accessor :part_number

    # The PEGI rating attribute of the item.
    attr_accessor :pegi_rating

    # The platform attributes of the item.
    attr_accessor :platform

    # The processor count attribute of the item.
    attr_accessor :processor_count

    # The product group attribute of the item.
    attr_accessor :product_group

    # The product type name attribute of the item.
    attr_accessor :product_type_name

    # The product type subcategory attribute of the item.
    attr_accessor :product_type_subcategory

    # The publication date attribute of the item.
    attr_accessor :publication_date

    # The publisher attribute of the item.
    attr_accessor :publisher

    # The region code attribute of the item.
    attr_accessor :region_code

    # The release date attribute of the item.
    attr_accessor :release_date

    # The ring size attribute of the item.
    attr_accessor :ring_size

    attr_accessor :running_time

    # The shaft material attribute of the item.
    attr_accessor :shaft_material

    # The scent attribute of the item.
    attr_accessor :scent

    # The season sequence attribute of the item.
    attr_accessor :season_sequence

    # The Seikodo product code attribute of the item.
    attr_accessor :seikodo_product_code

    # The size attribute of the item.
    attr_accessor :size

    # The size per pearl attribute of the item.
    attr_accessor :size_per_pearl

    attr_accessor :small_image

    # The studio attribute of the item.
    attr_accessor :studio

    attr_accessor :subscription_length

    attr_accessor :system_memory_size

    # The system memory type attribute of the item.
    attr_accessor :system_memory_type

    # The theatrical release date attribute of the item.
    attr_accessor :theatrical_release_date

    # The title attribute of the item.
    attr_accessor :title

    attr_accessor :total_diamond_weight

    attr_accessor :total_gem_weight

    # The warranty attribute of the item.
    attr_accessor :warranty

    attr_accessor :weee_tax_value

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'actor' => :'Actor',
        :'artist' => :'Artist',
        :'aspect_ratio' => :'AspectRatio',
        :'audience_rating' => :'AudienceRating',
        :'author' => :'Author',
        :'back_finding' => :'BackFinding',
        :'band_material_type' => :'BandMaterialType',
        :'binding' => :'Binding',
        :'bluray_region' => :'BlurayRegion',
        :'brand' => :'Brand',
        :'cero_age_rating' => :'CeroAgeRating',
        :'chain_type' => :'ChainType',
        :'clasp_type' => :'ClaspType',
        :'color' => :'Color',
        :'cpu_manufacturer' => :'CpuManufacturer',
        :'cpu_speed' => :'CpuSpeed',
        :'cpu_type' => :'CpuType',
        :'creator' => :'Creator',
        :'department' => :'Department',
        :'director' => :'Director',
        :'display_size' => :'DisplaySize',
        :'edition' => :'Edition',
        :'episode_sequence' => :'EpisodeSequence',
        :'esrb_age_rating' => :'EsrbAgeRating',
        :'feature' => :'Feature',
        :'flavor' => :'Flavor',
        :'format' => :'Format',
        :'gem_type' => :'GemType',
        :'genre' => :'Genre',
        :'golf_club_flex' => :'GolfClubFlex',
        :'golf_club_loft' => :'GolfClubLoft',
        :'hand_orientation' => :'HandOrientation',
        :'hard_disk_interface' => :'HardDiskInterface',
        :'hard_disk_size' => :'HardDiskSize',
        :'hardware_platform' => :'HardwarePlatform',
        :'hazardous_material_type' => :'HazardousMaterialType',
        :'item_dimensions' => :'ItemDimensions',
        :'is_adult_product' => :'IsAdultProduct',
        :'is_autographed' => :'IsAutographed',
        :'is_eligible_for_trade_in' => :'IsEligibleForTradeIn',
        :'is_memorabilia' => :'IsMemorabilia',
        :'issues_per_year' => :'IssuesPerYear',
        :'item_part_number' => :'ItemPartNumber',
        :'label' => :'Label',
        :'languages' => :'Languages',
        :'legal_disclaimer' => :'LegalDisclaimer',
        :'list_price' => :'ListPrice',
        :'manufacturer' => :'Manufacturer',
        :'manufacturer_maximum_age' => :'ManufacturerMaximumAge',
        :'manufacturer_minimum_age' => :'ManufacturerMinimumAge',
        :'manufacturer_parts_warranty_description' => :'ManufacturerPartsWarrantyDescription',
        :'material_type' => :'MaterialType',
        :'maximum_resolution' => :'MaximumResolution',
        :'media_type' => :'MediaType',
        :'metal_stamp' => :'MetalStamp',
        :'metal_type' => :'MetalType',
        :'model' => :'Model',
        :'number_of_discs' => :'NumberOfDiscs',
        :'number_of_issues' => :'NumberOfIssues',
        :'number_of_items' => :'NumberOfItems',
        :'number_of_pages' => :'NumberOfPages',
        :'number_of_tracks' => :'NumberOfTracks',
        :'operating_system' => :'OperatingSystem',
        :'optical_zoom' => :'OpticalZoom',
        :'package_dimensions' => :'PackageDimensions',
        :'package_quantity' => :'PackageQuantity',
        :'part_number' => :'PartNumber',
        :'pegi_rating' => :'PegiRating',
        :'platform' => :'Platform',
        :'processor_count' => :'ProcessorCount',
        :'product_group' => :'ProductGroup',
        :'product_type_name' => :'ProductTypeName',
        :'product_type_subcategory' => :'ProductTypeSubcategory',
        :'publication_date' => :'PublicationDate',
        :'publisher' => :'Publisher',
        :'region_code' => :'RegionCode',
        :'release_date' => :'ReleaseDate',
        :'ring_size' => :'RingSize',
        :'running_time' => :'RunningTime',
        :'shaft_material' => :'ShaftMaterial',
        :'scent' => :'Scent',
        :'season_sequence' => :'SeasonSequence',
        :'seikodo_product_code' => :'SeikodoProductCode',
        :'size' => :'Size',
        :'size_per_pearl' => :'SizePerPearl',
        :'small_image' => :'SmallImage',
        :'studio' => :'Studio',
        :'subscription_length' => :'SubscriptionLength',
        :'system_memory_size' => :'SystemMemorySize',
        :'system_memory_type' => :'SystemMemoryType',
        :'theatrical_release_date' => :'TheatricalReleaseDate',
        :'title' => :'Title',
        :'total_diamond_weight' => :'TotalDiamondWeight',
        :'total_gem_weight' => :'TotalGemWeight',
        :'warranty' => :'Warranty',
        :'weee_tax_value' => :'WeeeTaxValue'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'actor' => :'Object',
        :'artist' => :'Object',
        :'aspect_ratio' => :'Object',
        :'audience_rating' => :'Object',
        :'author' => :'Object',
        :'back_finding' => :'Object',
        :'band_material_type' => :'Object',
        :'binding' => :'Object',
        :'bluray_region' => :'Object',
        :'brand' => :'Object',
        :'cero_age_rating' => :'Object',
        :'chain_type' => :'Object',
        :'clasp_type' => :'Object',
        :'color' => :'Object',
        :'cpu_manufacturer' => :'Object',
        :'cpu_speed' => :'Object',
        :'cpu_type' => :'Object',
        :'creator' => :'Object',
        :'department' => :'Object',
        :'director' => :'Object',
        :'display_size' => :'Object',
        :'edition' => :'Object',
        :'episode_sequence' => :'Object',
        :'esrb_age_rating' => :'Object',
        :'feature' => :'Object',
        :'flavor' => :'Object',
        :'format' => :'Object',
        :'gem_type' => :'Object',
        :'genre' => :'Object',
        :'golf_club_flex' => :'Object',
        :'golf_club_loft' => :'Object',
        :'hand_orientation' => :'Object',
        :'hard_disk_interface' => :'Object',
        :'hard_disk_size' => :'Object',
        :'hardware_platform' => :'Object',
        :'hazardous_material_type' => :'Object',
        :'item_dimensions' => :'Object',
        :'is_adult_product' => :'Object',
        :'is_autographed' => :'Object',
        :'is_eligible_for_trade_in' => :'Object',
        :'is_memorabilia' => :'Object',
        :'issues_per_year' => :'Object',
        :'item_part_number' => :'Object',
        :'label' => :'Object',
        :'languages' => :'Object',
        :'legal_disclaimer' => :'Object',
        :'list_price' => :'Object',
        :'manufacturer' => :'Object',
        :'manufacturer_maximum_age' => :'Object',
        :'manufacturer_minimum_age' => :'Object',
        :'manufacturer_parts_warranty_description' => :'Object',
        :'material_type' => :'Object',
        :'maximum_resolution' => :'Object',
        :'media_type' => :'Object',
        :'metal_stamp' => :'Object',
        :'metal_type' => :'Object',
        :'model' => :'Object',
        :'number_of_discs' => :'Object',
        :'number_of_issues' => :'Object',
        :'number_of_items' => :'Object',
        :'number_of_pages' => :'Object',
        :'number_of_tracks' => :'Object',
        :'operating_system' => :'Object',
        :'optical_zoom' => :'Object',
        :'package_dimensions' => :'Object',
        :'package_quantity' => :'Object',
        :'part_number' => :'Object',
        :'pegi_rating' => :'Object',
        :'platform' => :'Object',
        :'processor_count' => :'Object',
        :'product_group' => :'Object',
        :'product_type_name' => :'Object',
        :'product_type_subcategory' => :'Object',
        :'publication_date' => :'Object',
        :'publisher' => :'Object',
        :'region_code' => :'Object',
        :'release_date' => :'Object',
        :'ring_size' => :'Object',
        :'running_time' => :'Object',
        :'shaft_material' => :'Object',
        :'scent' => :'Object',
        :'season_sequence' => :'Object',
        :'seikodo_product_code' => :'Object',
        :'size' => :'Object',
        :'size_per_pearl' => :'Object',
        :'small_image' => :'Object',
        :'studio' => :'Object',
        :'subscription_length' => :'Object',
        :'system_memory_size' => :'Object',
        :'system_memory_type' => :'Object',
        :'theatrical_release_date' => :'Object',
        :'title' => :'Object',
        :'total_diamond_weight' => :'Object',
        :'total_gem_weight' => :'Object',
        :'warranty' => :'Object',
        :'weee_tax_value' => :'Object'
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
        fail ArgumentError, "The input argument (attributes) must be a hash in `AmzSpApi::CatalogItemsApiModelV0::AttributeSetListType` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `AmzSpApi::CatalogItemsApiModelV0::AttributeSetListType`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'actor')
        if (value = attributes[:'actor']).is_a?(Array)
          self.actor = value
        end
      end

      if attributes.key?(:'artist')
        if (value = attributes[:'artist']).is_a?(Array)
          self.artist = value
        end
      end

      if attributes.key?(:'aspect_ratio')
        self.aspect_ratio = attributes[:'aspect_ratio']
      end

      if attributes.key?(:'audience_rating')
        self.audience_rating = attributes[:'audience_rating']
      end

      if attributes.key?(:'author')
        if (value = attributes[:'author']).is_a?(Array)
          self.author = value
        end
      end

      if attributes.key?(:'back_finding')
        self.back_finding = attributes[:'back_finding']
      end

      if attributes.key?(:'band_material_type')
        self.band_material_type = attributes[:'band_material_type']
      end

      if attributes.key?(:'binding')
        self.binding = attributes[:'binding']
      end

      if attributes.key?(:'bluray_region')
        self.bluray_region = attributes[:'bluray_region']
      end

      if attributes.key?(:'brand')
        self.brand = attributes[:'brand']
      end

      if attributes.key?(:'cero_age_rating')
        self.cero_age_rating = attributes[:'cero_age_rating']
      end

      if attributes.key?(:'chain_type')
        self.chain_type = attributes[:'chain_type']
      end

      if attributes.key?(:'clasp_type')
        self.clasp_type = attributes[:'clasp_type']
      end

      if attributes.key?(:'color')
        self.color = attributes[:'color']
      end

      if attributes.key?(:'cpu_manufacturer')
        self.cpu_manufacturer = attributes[:'cpu_manufacturer']
      end

      if attributes.key?(:'cpu_speed')
        self.cpu_speed = attributes[:'cpu_speed']
      end

      if attributes.key?(:'cpu_type')
        self.cpu_type = attributes[:'cpu_type']
      end

      if attributes.key?(:'creator')
        if (value = attributes[:'creator']).is_a?(Array)
          self.creator = value
        end
      end

      if attributes.key?(:'department')
        self.department = attributes[:'department']
      end

      if attributes.key?(:'director')
        if (value = attributes[:'director']).is_a?(Array)
          self.director = value
        end
      end

      if attributes.key?(:'display_size')
        self.display_size = attributes[:'display_size']
      end

      if attributes.key?(:'edition')
        self.edition = attributes[:'edition']
      end

      if attributes.key?(:'episode_sequence')
        self.episode_sequence = attributes[:'episode_sequence']
      end

      if attributes.key?(:'esrb_age_rating')
        self.esrb_age_rating = attributes[:'esrb_age_rating']
      end

      if attributes.key?(:'feature')
        if (value = attributes[:'feature']).is_a?(Array)
          self.feature = value
        end
      end

      if attributes.key?(:'flavor')
        self.flavor = attributes[:'flavor']
      end

      if attributes.key?(:'format')
        if (value = attributes[:'format']).is_a?(Array)
          self.format = value
        end
      end

      if attributes.key?(:'gem_type')
        if (value = attributes[:'gem_type']).is_a?(Array)
          self.gem_type = value
        end
      end

      if attributes.key?(:'genre')
        self.genre = attributes[:'genre']
      end

      if attributes.key?(:'golf_club_flex')
        self.golf_club_flex = attributes[:'golf_club_flex']
      end

      if attributes.key?(:'golf_club_loft')
        self.golf_club_loft = attributes[:'golf_club_loft']
      end

      if attributes.key?(:'hand_orientation')
        self.hand_orientation = attributes[:'hand_orientation']
      end

      if attributes.key?(:'hard_disk_interface')
        self.hard_disk_interface = attributes[:'hard_disk_interface']
      end

      if attributes.key?(:'hard_disk_size')
        self.hard_disk_size = attributes[:'hard_disk_size']
      end

      if attributes.key?(:'hardware_platform')
        self.hardware_platform = attributes[:'hardware_platform']
      end

      if attributes.key?(:'hazardous_material_type')
        self.hazardous_material_type = attributes[:'hazardous_material_type']
      end

      if attributes.key?(:'item_dimensions')
        self.item_dimensions = attributes[:'item_dimensions']
      end

      if attributes.key?(:'is_adult_product')
        self.is_adult_product = attributes[:'is_adult_product']
      end

      if attributes.key?(:'is_autographed')
        self.is_autographed = attributes[:'is_autographed']
      end

      if attributes.key?(:'is_eligible_for_trade_in')
        self.is_eligible_for_trade_in = attributes[:'is_eligible_for_trade_in']
      end

      if attributes.key?(:'is_memorabilia')
        self.is_memorabilia = attributes[:'is_memorabilia']
      end

      if attributes.key?(:'issues_per_year')
        self.issues_per_year = attributes[:'issues_per_year']
      end

      if attributes.key?(:'item_part_number')
        self.item_part_number = attributes[:'item_part_number']
      end

      if attributes.key?(:'label')
        self.label = attributes[:'label']
      end

      if attributes.key?(:'languages')
        if (value = attributes[:'languages']).is_a?(Array)
          self.languages = value
        end
      end

      if attributes.key?(:'legal_disclaimer')
        self.legal_disclaimer = attributes[:'legal_disclaimer']
      end

      if attributes.key?(:'list_price')
        self.list_price = attributes[:'list_price']
      end

      if attributes.key?(:'manufacturer')
        self.manufacturer = attributes[:'manufacturer']
      end

      if attributes.key?(:'manufacturer_maximum_age')
        self.manufacturer_maximum_age = attributes[:'manufacturer_maximum_age']
      end

      if attributes.key?(:'manufacturer_minimum_age')
        self.manufacturer_minimum_age = attributes[:'manufacturer_minimum_age']
      end

      if attributes.key?(:'manufacturer_parts_warranty_description')
        self.manufacturer_parts_warranty_description = attributes[:'manufacturer_parts_warranty_description']
      end

      if attributes.key?(:'material_type')
        if (value = attributes[:'material_type']).is_a?(Array)
          self.material_type = value
        end
      end

      if attributes.key?(:'maximum_resolution')
        self.maximum_resolution = attributes[:'maximum_resolution']
      end

      if attributes.key?(:'media_type')
        if (value = attributes[:'media_type']).is_a?(Array)
          self.media_type = value
        end
      end

      if attributes.key?(:'metal_stamp')
        self.metal_stamp = attributes[:'metal_stamp']
      end

      if attributes.key?(:'metal_type')
        self.metal_type = attributes[:'metal_type']
      end

      if attributes.key?(:'model')
        self.model = attributes[:'model']
      end

      if attributes.key?(:'number_of_discs')
        self.number_of_discs = attributes[:'number_of_discs']
      end

      if attributes.key?(:'number_of_issues')
        self.number_of_issues = attributes[:'number_of_issues']
      end

      if attributes.key?(:'number_of_items')
        self.number_of_items = attributes[:'number_of_items']
      end

      if attributes.key?(:'number_of_pages')
        self.number_of_pages = attributes[:'number_of_pages']
      end

      if attributes.key?(:'number_of_tracks')
        self.number_of_tracks = attributes[:'number_of_tracks']
      end

      if attributes.key?(:'operating_system')
        if (value = attributes[:'operating_system']).is_a?(Array)
          self.operating_system = value
        end
      end

      if attributes.key?(:'optical_zoom')
        self.optical_zoom = attributes[:'optical_zoom']
      end

      if attributes.key?(:'package_dimensions')
        self.package_dimensions = attributes[:'package_dimensions']
      end

      if attributes.key?(:'package_quantity')
        self.package_quantity = attributes[:'package_quantity']
      end

      if attributes.key?(:'part_number')
        self.part_number = attributes[:'part_number']
      end

      if attributes.key?(:'pegi_rating')
        self.pegi_rating = attributes[:'pegi_rating']
      end

      if attributes.key?(:'platform')
        if (value = attributes[:'platform']).is_a?(Array)
          self.platform = value
        end
      end

      if attributes.key?(:'processor_count')
        self.processor_count = attributes[:'processor_count']
      end

      if attributes.key?(:'product_group')
        self.product_group = attributes[:'product_group']
      end

      if attributes.key?(:'product_type_name')
        self.product_type_name = attributes[:'product_type_name']
      end

      if attributes.key?(:'product_type_subcategory')
        self.product_type_subcategory = attributes[:'product_type_subcategory']
      end

      if attributes.key?(:'publication_date')
        self.publication_date = attributes[:'publication_date']
      end

      if attributes.key?(:'publisher')
        self.publisher = attributes[:'publisher']
      end

      if attributes.key?(:'region_code')
        self.region_code = attributes[:'region_code']
      end

      if attributes.key?(:'release_date')
        self.release_date = attributes[:'release_date']
      end

      if attributes.key?(:'ring_size')
        self.ring_size = attributes[:'ring_size']
      end

      if attributes.key?(:'running_time')
        self.running_time = attributes[:'running_time']
      end

      if attributes.key?(:'shaft_material')
        self.shaft_material = attributes[:'shaft_material']
      end

      if attributes.key?(:'scent')
        self.scent = attributes[:'scent']
      end

      if attributes.key?(:'season_sequence')
        self.season_sequence = attributes[:'season_sequence']
      end

      if attributes.key?(:'seikodo_product_code')
        self.seikodo_product_code = attributes[:'seikodo_product_code']
      end

      if attributes.key?(:'size')
        self.size = attributes[:'size']
      end

      if attributes.key?(:'size_per_pearl')
        self.size_per_pearl = attributes[:'size_per_pearl']
      end

      if attributes.key?(:'small_image')
        self.small_image = attributes[:'small_image']
      end

      if attributes.key?(:'studio')
        self.studio = attributes[:'studio']
      end

      if attributes.key?(:'subscription_length')
        self.subscription_length = attributes[:'subscription_length']
      end

      if attributes.key?(:'system_memory_size')
        self.system_memory_size = attributes[:'system_memory_size']
      end

      if attributes.key?(:'system_memory_type')
        self.system_memory_type = attributes[:'system_memory_type']
      end

      if attributes.key?(:'theatrical_release_date')
        self.theatrical_release_date = attributes[:'theatrical_release_date']
      end

      if attributes.key?(:'title')
        self.title = attributes[:'title']
      end

      if attributes.key?(:'total_diamond_weight')
        self.total_diamond_weight = attributes[:'total_diamond_weight']
      end

      if attributes.key?(:'total_gem_weight')
        self.total_gem_weight = attributes[:'total_gem_weight']
      end

      if attributes.key?(:'warranty')
        self.warranty = attributes[:'warranty']
      end

      if attributes.key?(:'weee_tax_value')
        self.weee_tax_value = attributes[:'weee_tax_value']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          actor == o.actor &&
          artist == o.artist &&
          aspect_ratio == o.aspect_ratio &&
          audience_rating == o.audience_rating &&
          author == o.author &&
          back_finding == o.back_finding &&
          band_material_type == o.band_material_type &&
          binding == o.binding &&
          bluray_region == o.bluray_region &&
          brand == o.brand &&
          cero_age_rating == o.cero_age_rating &&
          chain_type == o.chain_type &&
          clasp_type == o.clasp_type &&
          color == o.color &&
          cpu_manufacturer == o.cpu_manufacturer &&
          cpu_speed == o.cpu_speed &&
          cpu_type == o.cpu_type &&
          creator == o.creator &&
          department == o.department &&
          director == o.director &&
          display_size == o.display_size &&
          edition == o.edition &&
          episode_sequence == o.episode_sequence &&
          esrb_age_rating == o.esrb_age_rating &&
          feature == o.feature &&
          flavor == o.flavor &&
          format == o.format &&
          gem_type == o.gem_type &&
          genre == o.genre &&
          golf_club_flex == o.golf_club_flex &&
          golf_club_loft == o.golf_club_loft &&
          hand_orientation == o.hand_orientation &&
          hard_disk_interface == o.hard_disk_interface &&
          hard_disk_size == o.hard_disk_size &&
          hardware_platform == o.hardware_platform &&
          hazardous_material_type == o.hazardous_material_type &&
          item_dimensions == o.item_dimensions &&
          is_adult_product == o.is_adult_product &&
          is_autographed == o.is_autographed &&
          is_eligible_for_trade_in == o.is_eligible_for_trade_in &&
          is_memorabilia == o.is_memorabilia &&
          issues_per_year == o.issues_per_year &&
          item_part_number == o.item_part_number &&
          label == o.label &&
          languages == o.languages &&
          legal_disclaimer == o.legal_disclaimer &&
          list_price == o.list_price &&
          manufacturer == o.manufacturer &&
          manufacturer_maximum_age == o.manufacturer_maximum_age &&
          manufacturer_minimum_age == o.manufacturer_minimum_age &&
          manufacturer_parts_warranty_description == o.manufacturer_parts_warranty_description &&
          material_type == o.material_type &&
          maximum_resolution == o.maximum_resolution &&
          media_type == o.media_type &&
          metal_stamp == o.metal_stamp &&
          metal_type == o.metal_type &&
          model == o.model &&
          number_of_discs == o.number_of_discs &&
          number_of_issues == o.number_of_issues &&
          number_of_items == o.number_of_items &&
          number_of_pages == o.number_of_pages &&
          number_of_tracks == o.number_of_tracks &&
          operating_system == o.operating_system &&
          optical_zoom == o.optical_zoom &&
          package_dimensions == o.package_dimensions &&
          package_quantity == o.package_quantity &&
          part_number == o.part_number &&
          pegi_rating == o.pegi_rating &&
          platform == o.platform &&
          processor_count == o.processor_count &&
          product_group == o.product_group &&
          product_type_name == o.product_type_name &&
          product_type_subcategory == o.product_type_subcategory &&
          publication_date == o.publication_date &&
          publisher == o.publisher &&
          region_code == o.region_code &&
          release_date == o.release_date &&
          ring_size == o.ring_size &&
          running_time == o.running_time &&
          shaft_material == o.shaft_material &&
          scent == o.scent &&
          season_sequence == o.season_sequence &&
          seikodo_product_code == o.seikodo_product_code &&
          size == o.size &&
          size_per_pearl == o.size_per_pearl &&
          small_image == o.small_image &&
          studio == o.studio &&
          subscription_length == o.subscription_length &&
          system_memory_size == o.system_memory_size &&
          system_memory_type == o.system_memory_type &&
          theatrical_release_date == o.theatrical_release_date &&
          title == o.title &&
          total_diamond_weight == o.total_diamond_weight &&
          total_gem_weight == o.total_gem_weight &&
          warranty == o.warranty &&
          weee_tax_value == o.weee_tax_value
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [actor, artist, aspect_ratio, audience_rating, author, back_finding, band_material_type, binding, bluray_region, brand, cero_age_rating, chain_type, clasp_type, color, cpu_manufacturer, cpu_speed, cpu_type, creator, department, director, display_size, edition, episode_sequence, esrb_age_rating, feature, flavor, format, gem_type, genre, golf_club_flex, golf_club_loft, hand_orientation, hard_disk_interface, hard_disk_size, hardware_platform, hazardous_material_type, item_dimensions, is_adult_product, is_autographed, is_eligible_for_trade_in, is_memorabilia, issues_per_year, item_part_number, label, languages, legal_disclaimer, list_price, manufacturer, manufacturer_maximum_age, manufacturer_minimum_age, manufacturer_parts_warranty_description, material_type, maximum_resolution, media_type, metal_stamp, metal_type, model, number_of_discs, number_of_issues, number_of_items, number_of_pages, number_of_tracks, operating_system, optical_zoom, package_dimensions, package_quantity, part_number, pegi_rating, platform, processor_count, product_group, product_type_name, product_type_subcategory, publication_date, publisher, region_code, release_date, ring_size, running_time, shaft_material, scent, season_sequence, seikodo_product_code, size, size_per_pearl, small_image, studio, subscription_length, system_memory_size, system_memory_type, theatrical_release_date, title, total_diamond_weight, total_gem_weight, warranty, weee_tax_value].hash
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
        AmzSpApi::CatalogItemsApiModelV0.const_get(type).build_from_hash(value)
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
