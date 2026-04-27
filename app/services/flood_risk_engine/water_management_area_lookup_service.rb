# frozen_string_literal: true

module FloodRiskEngine
  class WaterManagementAreaLookupService < BaseService
    def run(easting:, northing:)
      # We use Integer() to validate that the easting and northing strings can be converted into
      # valid integers. Integer() treats values with leading zeroes as octal, so we remove those
      # before attempting to convert to integer.
      easting_str = easting.sub(/^0+/, "")
      northing_str = northing.sub(/^0+/, "")

      # Integer() validates and converts; raises ArgumentError for non-integer strings
      easting_int = easting_str.present? ? Integer(easting_str) : 0
      northing_int = northing_str.present? ? Integer(northing_str) : 0

      administrative_areas = FloodRiskEngine::WaterManagementArea.arel_table
      point = RGeo::Cartesian.preferred_factory.point(easting_int, northing_int)

      FloodRiskEngine::WaterManagementArea.where(administrative_areas[:area].st_contains(point)).first
    rescue NoMethodError
      raise ArgumentError, "Invalid easting/northing values (#{easting}/#{northing}), integers required"
    end
  end
end
