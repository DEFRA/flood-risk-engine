require "os_map_ref"

module FloodRiskEngine
  class Location < ActiveRecord::Base
    belongs_to :locatable, polymorphic: true
    belongs_to :water_management_area

    before_save :process_grid_reference

    scope :missing_area, -> { where(water_management_area: nil) }
    scope :with_easting_and_northing, -> { where.not(easting: [nil, ""], northing: [nil, ""]) }

    # rubocop:disable Style/Lambda
    # This version of ruby does not like lambdas here
    scope :from_site_address, -> do
      joins("JOIN flood_risk_engine_addresses as addresses ON addresses.id = flood_risk_engine_locations.locatable_id")
        .where("addresses.address_type = ?", 2)
        .where(locatable_type: "FloodRiskEngine::Address")
    end
    # rubocop:enable Style/Lambda

    private

    def process_grid_reference
      return true unless changed.include?("grid_reference")

      data = OsMapRef::Location.for grid_reference
      self.grid_reference = data.map_reference
      self.easting = data.easting
      self.northing = data.northing
    end
  end
end
