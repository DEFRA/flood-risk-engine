module FloodRiskEngine
  class UpdateWaterManagementAreaJob < ActiveJob::Base
    def perform(location)
      raise MissingLocationArgumentError unless location

      Location.transaction do
        location.water_management_area = get_area_for(location)
        location.save!
      end
    end

    private

    def get_area_for(location)
      api_result = lookup_area_using_using_external_api(location)

      if inside_england?(api_result)
        find_or_create_area_from_api_result(api_result)
      else
        WaterManagementArea.outside_england_area
      end
    end

    def lookup_area_using_using_external_api(location)
      coords = EA::AreaLookup::Coordinates.new(easting: location.easting,
                                               northing: location.northing)
      EA::AreaLookup.find_water_management_area_by_coordinates(coords)
    end

    def find_or_create_area_from_api_result(api_result)
      WaterManagementArea.find_or_create_by(code: api_result[:code]) do |area|
        area.update_attributes(api_result)
      end
    end

    def inside_england?(api_result)
      api_result[:long_name].present?
    end
  end
end
