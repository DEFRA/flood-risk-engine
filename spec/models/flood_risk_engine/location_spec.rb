require "rails_helper"

module FloodRiskEngine
  RSpec.describe Location, type: :model do
    it { is_expected.to belong_to(:locatable) }

    let(:palace) do
      OpenStruct.new(
        postcode: "SW1A 1AA",
        grid_reference: "TQ 29090 79645",
        easting: "529090",
        northing: "179645",
        latitude: 51.501009,
        longitude: -0.1415876
      )
    end

    let(:mountain) do
      OpenStruct.new(
        postcode: "LL55 4UL",
        grid_reference: "SH 60992 54374",
        easting: "260992",
        northing: "354374",
        latitude: 53.068468,
        longitude: -4.0761369
      )
    end

    describe "grid reference processing" do
      let(:location) { Location.create(grid_reference: palace.grid_reference.delete(" ")) }

      it "should tidy format of grid reference" do
        expect(location.grid_reference).to eq(palace.grid_reference)
      end

      it "should save coresponding easting and northing" do
        expect(location.easting.to_i).to eq(palace.easting.to_i)
        expect(location.northing.to_i).to eq(palace.northing.to_i)
      end

      it "should allow grid reference to be changed" do
        location.update_attribute :grid_reference, mountain.grid_reference
        expect(location.grid_reference).to eq(mountain.grid_reference)
        expect(location.easting.to_i).to eq(mountain.easting.to_i)
        expect(location.northing.to_i).to eq(mountain.northing.to_i)
      end
    end
  end
end
