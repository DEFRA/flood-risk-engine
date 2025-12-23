# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe Address do
    let(:address) { create(:address) }

    it { is_expected.to belong_to(:addressable) }
    it { is_expected.to have_one(:location).dependent(:restrict_with_exception) }

    describe "#parts" do
      let(:fields) { %i[premises street_address locality city postcode] }
      let(:address_parts) { fields.collect { |f| address.send(f) } }

      it "returns a list of the address parts" do
        expect(address.parts).to eq(address_parts)
      end

      context "when not all fields present" do
        before do
          address.locality = ""
          fields.delete :locality
        end

        it "returns a list with just the address parts present" do
          expect(address.parts).to eq(address_parts)
        end
      end
    end

    describe "#clean_up_duplicate_addresses" do
      let(:enrollment) { build(:enrollment, :with_individual) }
      let(:org_addresses) { described_class.where(addressable: enrollment.organisation) }
      let(:address) do
        build(:address,
              postcode: "BS1 1AA",
              address_type: :primary)
      end

      context "when there are no pre-existing addresses for this enrollment" do
        before do
          org_addresses.each(&:delete)
        end

        it "saves the new address and does not remove any other addresses" do
          expect(org_addresses).to be_empty

          address.addressable = enrollment.organisation
          address.save!

          expect(org_addresses.reload).to eq([address])
        end
      end

      context "when there is a pre-existing address for this enrollment" do
        let!(:enrollment) { create(:enrollment, :with_individual, :with_organisation_address) }
        let(:existing_address) { enrollment.organisation.primary_address }

        context "when the pre-existing address is a primary address" do
          it "saves the new address and removes the old address" do
            expect(org_addresses).to eq([existing_address])

            address.addressable = enrollment.organisation
            address.save!

            expect(org_addresses.reload).to eq([address])
          end
        end

        context "when the pre-existing address is not a primary address" do
          let!(:enrollment) { create(:enrollment, :with_individual, :with_correspondence_contact) }
          let(:existing_address) { create(:address, addressable: enrollment.correspondence_contact) }
          let(:contact_addresses) { described_class.where(addressable: enrollment.correspondence_contact) }

          it "saves the new address and does not remove any other addresses" do
            expect(org_addresses).to eq([])
            expect(contact_addresses).to eq([existing_address])

            address.addressable = enrollment.organisation
            address.save!

            expect(org_addresses.reload).to eq([address])
            expect(contact_addresses.reload).to eq([existing_address])
          end
        end
      end
    end
  end
end
