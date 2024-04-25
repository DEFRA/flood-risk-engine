# frozen_string_literal: true

module FloodRiskEngine
  class WaterManagementAreaLookupService < BaseService
    def run(easting:, northing:)
      # Validate the input values
      Integer(easting) && Integer(northing)

      administrative_areas = FloodRiskEngine::WaterManagementArea.arel_table
      point = RGeo::Cartesian.preferred_factory.point(easting, northing)

      FloodRiskEngine::WaterManagementArea.where(administrative_areas[:area].st_contains(point)).first
    rescue ArgumentError, TypeError
      raise ArgumentError, "Invalid easting/northing values (#{easting}/#{northing}), integers required"
    end
  end
end
