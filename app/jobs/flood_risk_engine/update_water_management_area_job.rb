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
      response = DefraRuby::Area::WaterManagementAreaService.run(location.easting, location.northing)

      return process_successful_response(response.area) if response.successful?

      process_unsucessful_response(response)
    end

    def process_successful_response(result)
      WaterManagementArea.find_or_create_by(code: result.code) do |area|
        area.update_attributes(
          area_id: result.area_id,
          area_name: result.area_name,
          short_name: result.short_name,
          long_name: result.long_name
        )
      end
    end

    def process_unsucessful_response(response)
      return WaterManagementArea.outside_england_area if response.error.instance_of?(DefraRuby::Area::NoMatchError)

      # Any other error we just return nil
      nil
    end
  end
end
