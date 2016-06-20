require "rails_helper"

module FloodRiskEngine
  RSpec.describe Address, type: :model do
    it { is_expected.to belong_to(:addressable) }
    it { is_expected.to have_one(:location).dependent(:restrict_with_exception) }

    let(:address) { FactoryGirl.create(:address) }

    describe "#parts" do
      let(:fields) { [:premises, :street_address, :locality, :city, :postcode] }
      let(:address_parts) { fields.collect { |f| address.send(f) } }
      it "should return a list of the address parts" do
        expect(address.parts).to eq(address_parts)
      end

      context "when not all fields present" do
        before do
          address.locality = ""
          fields.delete :locality
        end

        it "should return a list with just the address parts present" do
          expect(address.parts).to eq(address_parts)
        end
      end
    end
  end
end
