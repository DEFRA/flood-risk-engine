require "os_map_ref"

module FloodRiskEngine
  class Location < ActiveRecord::Base
    belongs_to :locatable, polymorphic: true
    belongs_to :water_management_area

    before_save :process_grid_reference

    scope :missing_area, -> { where(water_management_area: nil) }
    scope :with_easting_and_northing, -> { where.not(easting: [nil, ""], northing: [nil, ""]) }

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
