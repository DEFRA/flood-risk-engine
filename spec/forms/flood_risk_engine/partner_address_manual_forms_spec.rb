# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe PartnerAddressManualForm, type: :model do
    before { VCR.insert_cassette("address_manual_valid_postcode") }
    after { VCR.eject_cassette }

    # Make sure the transient registration gets updated when submitted.
    describe "#submit" do
      let(:partner_address_manual_form) { build(:partner_address_manual_form, :has_required_data) }

      context "when the form is valid" do
        let(:address_data) do
          {
            transient_address: {
              premises: "Example House",
              street_address: "2 On The Road",
              locality: "Near Horizon House",
              city: "Bristol",
              postcode: "BS1 5AH"
            }
          }
        end
        let(:white_space_address_data) do
          {
            transient_address: {
              premises: "  Example House ",
              street_address: " 2 On The Road  ",
              locality: " Near Horizon House   ",
              city: "  Bristol  ",
              postcode: "   BS1 5AH  "
            }
          }
        end
        let(:valid_params) { address_data }
        let(:white_space_params) { white_space_address_data }
        let(:transient_registration) { partner_address_manual_form.transient_registration }

        it "updates the transient registration with the submitted address data" do
          # Ensure the test data is properly configured:
          expect(transient_registration.transient_people.first.transient_address).to be_nil

          partner_address_manual_form.submit(valid_params)

          submitted_address = transient_registration.transient_people.first.reload.transient_address
          address_data[:transient_address].each do |key, value|
            expect(submitted_address.send(key)).to eq(value)
          end
        end

        context "when the address data includes extraneous white space" do
          it "strips the extraneous white space from the submitted address data" do
            # Ensure the test data is properly configured:
            address_data[:transient_address].each do |key, value|
              expect(white_space_params[:transient_address][key]).not_to eq(value)
              expect(white_space_params[:transient_address][key].strip).to eq(value)
            end

            expect(transient_registration.transient_people.first.transient_address).to be_nil

            partner_address_manual_form.submit(valid_params)

            submitted_address = transient_registration.transient_people.first.reload.transient_address
            address_data[:transient_address].each do |key, value|
              expect(submitted_address.send(key)).to eq(value)
            end
          end
        end
      end

      context "when the form is not valid" do
        let(:invalid_params) do
          {
            partner_address: {
              premises: "",
              street_address: "",
              locality: "",
              city: "",
              postcode: ""
            }
          }
        end

        it "does not submit" do
          expect(partner_address_manual_form.submit(invalid_params)).to be(false)
        end
      end
    end
  end
end
