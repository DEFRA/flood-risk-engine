# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "CompanyAddressLookupForms" do
    describe "GET company_address_lookup_form_path" do
      it_behaves_like "GET flexible form", "company_address_lookup_form"
    end

    describe "POST company_address_lookup_form_path" do
      before { VCR.insert_cassette("address_lookup_valid_postcode", allow_playback_repeats: true) }
      after { VCR.eject_cassette }

      let(:transient_registration) do
        create(:new_registration,
               temp_company_postcode: "BS1 5AH",
               workflow_state: "company_address_lookup_form")
      end

      it_behaves_like "POST form",
                      "company_address_lookup_form",
                      valid_params: { company_address: { uprn: "340116" } },
                      invalid_params: { company_address: {} }
    end

    describe "GET back_company_address_lookup_forms_path" do
      context "when a valid transient registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "company_address_lookup_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the company_postcode form" do
            get back_company_address_lookup_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_company_postcode_form_path(transient_registration[:token]))
          end
        end
      end

      context "when the transient registration is in the wrong state" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "declaration_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the correct form for the state" do
            get back_company_address_lookup_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_declaration_form_path(transient_registration[:token]))
          end
        end
      end
    end
  end
end
