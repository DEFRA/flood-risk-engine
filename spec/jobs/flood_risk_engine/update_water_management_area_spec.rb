require "rails_helper"

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
        it "saves to the location" do
          location = FactoryBot.build_stubbed(
            :location,
            easting: "356954",
            northing: "210303"
          )
          area_hash_from_api = { area_id: "37.0",
                                 code: "W1",
                                 area_name: "an",
                                 short_name: "sn",
                                 long_name: "ln" }
          expect(EA::AreaLookup)
            .to receive(:find_water_management_area_by_coordinates)
            .and_return(area_hash_from_api)

          expect(location.water_management_area).to be_nil

          described_class.perform_now(location)

          area = location.water_management_area
          expect(area).to be_present
          expect(area).to be_persisted
          expect(area.area_id).to eq(area_hash_from_api[:area_id].to_i)
          expect(area.code).to eq(area_hash_from_api[:code])
          expect(area.area_name).to eq(area_hash_from_api[:area_name])
          expect(area.short_name).to eq(area_hash_from_api[:short_name])
        end
      end

      context "when no matching area found" do
        it "saves the 'Outside Engine' area to the location" do
          location = FactoryBot.build_stubbed(
            :location,
            easting: "438920",
            northing: "1164159"
          )
          area_hash_from_api = { area_id: "",
                                 code: "",
                                 area_name: "",
                                 short_name: "",
                                 long_name: "" }
          expect(EA::AreaLookup)
            .to receive(:find_water_management_area_by_coordinates)
            .and_return(area_hash_from_api)

          described_class.perform_now(location)

          area = location.water_management_area
          expect(area.area_name).to eq("Outside England")
        end
      end
    end
  end
end
