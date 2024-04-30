# frozen_string_literal: true

module FloodRiskEngine
  class WaterManagementAreaLookupService < BaseService
    def run(easting:, northing:)
      # We use Integer() to validate that the easting and northing strings can be converted into
      # valid integers. Integer() treats values with leading zeroes as octal, so we remove those
      # before attempting to convert to integer.
      easting_int = easting.sub(/^0+/, "")
      northing_int = northing.sub(/^0+/, "")

      # Use Integer() to raise an exception if not valid integers
      easting_int.present? && Integer(easting_int)
      northing_int.present? && Integer(northing_int)

      administrative_areas = FloodRiskEngine::WaterManagementArea.arel_table
      point = RGeo::Cartesian.preferred_factory.point(easting_int, northing_int)

      FloodRiskEngine::WaterManagementArea.where(administrative_areas[:area].st_contains(point)).first
    rescue NoMethodError
      raise ArgumentError, "Invalid easting/northing values (#{easting_int}/#{northing_int}), integers required"
    end
  end
end
