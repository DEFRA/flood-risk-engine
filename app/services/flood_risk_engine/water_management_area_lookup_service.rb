# frozen_string_literal: true

module FloodRiskEngine
  class WaterManagementAreaLookupService < BaseService
    def run(easting:, northing:)
      unless easting&.to_i&.positive? && northing&.to_i&.positive?
        raise ArgumentError, "Invalid easting/northing values (#{easting}/#{northing}), integers required"
      end

      administrative_areas = FloodRiskEngine::WaterManagementArea.arel_table
      point = RGeo::Cartesian.preferred_factory.point(easting, northing)

      FloodRiskEngine::WaterManagementArea.where(administrative_areas[:area].st_contains(point)).first
    end
  end
end
