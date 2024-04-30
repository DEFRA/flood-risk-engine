# frozen_string_literal: true

require "rails_helper"

# This job level spec is more of an integration spec so we let VCR
# handle the outgoing request.
module FloodRiskEngine
  describe UpdateWaterManagementAreaJob do
    let(:location) { FactoryBot.create(:location) }

    it { is_expected.to respond_to :perform }

    it "raises an exception if location not supplied" do
      expect { described_class.perform_now(nil) }
        .to raise_error MissingLocationArgumentError
    end

    describe "searching for an area via api lookup" do
      let(:water_management_area) { WaterManagementArea.new }

      context "when the area is found" do
        before { allow(WaterManagementAreaLookupService).to receive(:run).and_return(water_management_area) }

        it "saves to the location" do
          expect(location.water_management_area).to be_nil

          described_class.perform_now(location)

          area = location.water_management_area
          expect(area).to be_present
        end
      end

      context "when no matching area is found" do
        before { allow(WaterManagementAreaLookupService).to receive(:run).and_return(nil) }

        it "saves the 'Outside Engine' area to the location" do
          described_class.perform_now(location)

          area = location.water_management_area
          expect(area.area_name).to eq("Outside England")
        end
      end

      context "when the lookup encounters an error" do
        let(:coordinates) { { easting: location.easting, northing: location.northing } }

        before { allow(WaterManagementAreaLookupService).to receive(:run).and_raise(StandardError) }

        it "sends a notification to Errbit" do
          allow(Airbrake).to receive(:notify)

          expect { described_class.perform_now(location) }.to raise_error(StandardError)

          expect(Airbrake).to have_received(:notify)
        end
      end
    end
  end
end
