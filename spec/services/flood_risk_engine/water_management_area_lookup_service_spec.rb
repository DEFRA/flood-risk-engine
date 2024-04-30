# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe WaterManagementAreaLookupService, type: :service do
    describe ".run" do
      subject(:run_service) { described_class.run(easting:, northing:) }

      let(:test_feature) { RGeo::GeoJSON.decode(file_fixture("test_geo_feature.json")) }
      let(:area_result) { run_service }

      # Load a subset of the areas and once only for performance reasons
      before(:all) do # rubocop:disable RSpec/BeforeAfterAll
        create_water_management_area("1_DVNCWL")
        create_water_management_area("8_SLTSDN")
        create_water_management_area("12_DBNTLS")
        create_water_management_area("15_STWKWM")
      end
      after(:all) { FloodRiskEngine::WaterManagementArea.destroy_all } # rubocop:disable RSpec/BeforeAfterAll

      context "with nil easting/northing values" do
        let(:easting) { nil }
        let(:northing) { nil }

        it { expect { run_service }.to raise_error(ArgumentError) }
      end

      context "with invalid easting/northing values" do
        let(:easting) { "foo" }
        let(:northing) { " " }

        it { expect { run_service }.to raise_error(ArgumentError) }
      end

      context "with easting/northing outside England" do
        # Llandudno
        let(:easting) { "278180" }
        let(:northing) { "382349" }

        it { expect(area_result).to be_nil }
      end

      context "with valid easting/northing" do
        context "with a negative easting value" do
          let(:easting) { "-1000" }
          let(:northing) { "339188" }

          it { expect { run_service }.not_to raise_error }
        end

        context "with a northing value with a leading zero" do
          let(:easting) { "397563" }
          let(:northing) { "039188" }

          it { expect { run_service }.not_to raise_error }
        end

        context "with a location in Staffordshire" do
          let(:easting) { "397563" }
          let(:northing) { "339188" }

          it { expect(area_result.area_name).to eq "Staffordshire Warwickshire and West Midlands" }
        end

        context "with a location in South Downs" do
          let(:easting) { "430043" }
          let(:northing) { "144612" }

          it { expect(area_result.area_name).to eq "Solent and South Downs" }
        end

        context "with a location in a polygonal area" do
          # Nottingham
          let(:easting) { "457119" }
          let(:northing) { "340206" }

          it { expect(area_result.area_name).to eq "Derbyshire Nottinghamshire and Leicestershire" }
        end

        context "with a location in a multi-polygonal area" do
          # Cornwall
          let(:easting) { "204729" }
          let(:northing) { "61038" }

          it { expect(area_result.area_name).to eq "Devon and Cornwall" }
        end
      end
    end
  end
end

def create_water_management_area(id_and_code)
  geo_json = file_fixture("water_management_area_#{id_and_code}.json").read
  feature = RGeo::GeoJSON.decode(geo_json)
  FloodRiskEngine::WaterManagementArea.create!(
    code: feature["code"],
    area_name: feature["long_name"],
    area_id: feature.properties["identifier"],
    long_name: feature.properties["long_name"],
    short_name: feature.properties["short_name"],
    area: feature.geometry
  )
end
