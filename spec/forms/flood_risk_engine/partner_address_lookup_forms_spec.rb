# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe PartnerAddressLookupForm, type: :model do
    before(:each) { VCR.insert_cassette("address_lookup_valid_postcode") }
    after(:each) { VCR.eject_cassette }

    describe "#submit" do
      context "when the form is valid" do
        let(:partner_address_lookup_form) { build(:partner_address_lookup_form, :has_required_data) }
        let(:valid_params) do
          {
            token: partner_address_lookup_form.token,
            transient_address: {
              uprn: "340116"
            }
          }
        end
        let(:transient_registration) { partner_address_lookup_form.transient_registration }

        it "should submit" do
          expect(partner_address_lookup_form.submit(valid_params)).to eq(true)
        end

        it "saves the partner address" do
          partner_address_lookup_form.submit(valid_params)

          partner = transient_registration.transient_people.first.reload
          expect(partner.transient_address).to be_a(TransientAddress)
          expect(partner.transient_address.uprn).to eq(valid_params[:transient_address][:uprn])
        end
      end

      context "when the form is not valid" do
        let(:partner_address_lookup_form) { build(:partner_address_lookup_form, :has_required_data) }
        let(:invalid_params) { { token: "foo" } }

        it "should not submit" do
          expect(partner_address_lookup_form.submit(invalid_params)).to eq(false)
        end
      end
    end
  end
end
