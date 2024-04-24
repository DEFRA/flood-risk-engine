# frozen_string_literal: true

module FloodRiskEngine
  class UpdateWaterManagementAreaJob < ActiveJob::Base
    def perform(location)
      raise MissingLocationArgumentError unless location

      @location = location

      Location.transaction do
        @location.water_management_area = identify_area
        @location.save!
      end
    end

    private

    def identify_area
      area = FloodRiskEngine::WaterManagementAreaLookupService.run(
        easting: @location.easting,
        northing: @location.northing
      )

      area || WaterManagementArea.outside_england_area
    end
  end
end
