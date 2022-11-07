# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe CompanyAddressLookupForm, type: :model do
    before { VCR.insert_cassette("address_lookup_valid_postcode") }
    after { VCR.eject_cassette }

    describe "#submit" do
      context "when the form is valid" do
        let(:company_address_lookup_form) { build(:company_address_lookup_form, :has_required_data) }
        let(:valid_params) do
          {
            token: company_address_lookup_form.token,
            company_address: {
              uprn: "340116"
            }
          }
        end
        let(:transient_registration) { company_address_lookup_form.transient_registration }

        it "submits" do
          expect(company_address_lookup_form.submit(valid_params)).to be(true)
        end

        it "saves the company address" do
          company_address_lookup_form.submit(valid_params)

          expect(transient_registration.reload.company_address).to be_a(TransientAddress)
          expect(transient_registration.reload.company_address.uprn).to eq(valid_params[:company_address][:uprn])
        end
      end

      context "when the form is not valid" do
        let(:company_address_lookup_form) { build(:company_address_lookup_form, :has_required_data) }
        let(:invalid_params) { { token: "foo" } }

        it "does not submit" do
          expect(company_address_lookup_form.submit(invalid_params)).to be(false)
        end
      end
    end

    context "when the form's transient registration already has an address" do
      let(:transient_registration) do
        build(:new_registration,
              :has_company_address,
              workflow_state: "company_address_lookup_form")
      end
      # Don't use FactoryBot for this as we need to make sure it initializes with a specific object
      let(:company_address_lookup_form) { described_class.new(transient_registration) }

      describe "#temp_address" do
        it "pre-selects the address" do
          form_address = company_address_lookup_form.company_address.uprn.to_s
          registration_address = transient_registration.company_address.uprn.to_s
          expect(form_address).to eq(registration_address)
        end
      end
    end
  end
end
