require "rails_helper"

module Test
  module Area
    Response = Struct.new(:areas, :successful, :error) do
      def successful?
        successful
      end
    end

    Area = Struct.new(:area_id, :area_name, :code, :long_name, :short_name)
  end
end

# This job level spec is more of an integration spec so we let VCR
# handle the outgoing request.
module FloodRiskEngine
  describe UpdateWaterManagementAreaJob, type: :job do
    it { is_expected.to respond_to :perform }

    it "raises an exception if location not supplied" do
      expect { described_class.perform_now(nil) }
        .to raise_error MissingLocationArgumentError
    end

    describe "searching for an area via api lookup" do
      context "when the area is found" do
        let(:response) do
          area = Test::Area::Area.new(
            29,
            "Central",
            "STWKWM",
            "Staffordshire Warwickshire and West Midlands",
            "Staffs Warks and West Mids"
          )
          Test::Area::Response.new([area], true)
        end

        it "saves to the location" do
          location = FactoryBot.create(
            :location,
            easting: "408602",
            northing: "257535"
          )
          expect(DefraRuby::Area::WaterManagementAreaService)
            .to receive(:run)
            .and_return(response)

          expect(location.water_management_area).to be_nil

          described_class.perform_now(location)

          area = location.water_management_area
          expect(area).to be_present
          expect(area).to be_persisted
          test_area = response.areas.first
          expect(area.area_id).to eq(test_area.area_id)
          expect(area.code).to eq(test_area.code)
          expect(area.area_name).to eq(test_area.area_name)
          expect(area.short_name).to eq(test_area.short_name)
          expect(area.long_name).to eq(test_area.long_name)
        end
      end

      context "when no matching area found" do
        let(:response) { Test::Area::Response.new([], false, DefraRuby::Area::NoMatchError.new) }

        it "saves the 'Outside Engine' area to the location" do
          location = FactoryBot.create(
            :location,
            easting: "318371",
            northing: "176329"
          )
          expect(DefraRuby::Area::WaterManagementAreaService)
            .to receive(:run)
            .and_return(response)

          described_class.perform_now(location)

          area = location.water_management_area
          expect(area.area_name).to eq("Outside England")
        end
      end
    end
  end
end
