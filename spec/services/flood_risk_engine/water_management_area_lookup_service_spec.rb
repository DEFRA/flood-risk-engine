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

      context "with invalid easting/northing" do
        let(:easting) { nil }
        let(:northing) { nil }

        it { expect { run_service }.to raise_error(ArgumentError) }
      end

      context "with easting/northing outside England" do
        # Llandudno
        let(:easting) { 278_180 }
        let(:northing) { 382_349 }

        it { expect(area_result).to be_nil }
      end

      context "with valid easting/northing" do
        context "with a location in Staffordshire" do
          let(:easting) { 397_563 }
          let(:northing) { 339_188 }

          it { expect(area_result.area_name).to eq "Staffordshire Warwickshire and West Midlands" }
        end

        context "with a location in South Downs" do
          let(:easting) { 430_043 }
          let(:northing) { 144_612 }

          it { expect(area_result.area_name).to eq "Solent and South Downs" }
        end

        context "with a location in a polygonal area" do
          # Nottingham
          let(:easting) { 457_119 }
          let(:northing) { 340_206 }

          it { expect(area_result.area_name).to eq "Derbyshire Nottinghamshire and Leicestershire" }
        end

        context "with a location in a multi-polygonal area" do
          # Cornwall
          let(:easting) { 204_729 }
          let(:northing) { 61_038 }

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