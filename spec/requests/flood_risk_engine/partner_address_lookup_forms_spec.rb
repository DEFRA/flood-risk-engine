# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "PartnerAddressLookupForms" do
    describe "GET partner_address_lookup_form_path" do
      before do
        transient_registration.transient_people = [build(:transient_person, :named, :has_temp_postcode)]
      end

      it_behaves_like "GET flexible form", "partner_address_lookup_form"
    end

    describe "POST partner_address_lookup_form_path" do
      before { VCR.insert_cassette("address_lookup_valid_postcode", allow_playback_repeats: true) }
      after { VCR.eject_cassette }

      let(:transient_registration) do
        create(:new_registration,
               :has_named_partner_with_postcode,
               workflow_state: "partner_address_lookup_form")
      end

      it_behaves_like "POST form",
                      "partner_address_lookup_form",
                      valid_params: { transient_address: { uprn: "340116" } },
                      invalid_params: { transient_address: {} }
    end

    describe "GET back_partner_address_lookup_forms_path" do
      context "when a valid transient registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 :has_named_partner_with_postcode,
                 workflow_state: "partner_address_lookup_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the partner_postcode form" do
            get back_partner_address_lookup_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_partner_postcode_form_path(transient_registration[:token]))
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
            get back_partner_address_lookup_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_declaration_form_path(transient_registration[:token]))
          end
        end
      end
    end
  end
end
