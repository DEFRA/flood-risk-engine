# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "PartnerPostcodeForms", type: :request do
    describe "GET partner_postcode_form_path" do
      before do
        transient_registration.transient_people = [build(:transient_person, :named)]
      end

      include_examples "GET flexible form", "partner_postcode_form"
    end

    describe "POST partner_postcode_form_path" do
      let(:transient_registration) do
        create(:new_registration, :has_named_partner, workflow_state: "partner_postcode_form")
      end

      include_examples "POST form",
                       "partner_postcode_form",
                       valid_params: { temp_postcode: "BS1 5AH" },
                       invalid_params: { temp_postcode: "" }
    end

    describe "GET back_partner_postcode_forms_path" do
      context "when a valid transient registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 :has_named_partner,
                 workflow_state: "partner_postcode_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the partner_name form" do
            get back_partner_postcode_forms_path(transient_registration[:token])

            expect(response).to have_http_status(302)
            expect(response).to redirect_to(new_partner_name_form_path(transient_registration[:token]))
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
            get back_partner_postcode_forms_path(transient_registration[:token])

            expect(response).to have_http_status(302)
            expect(response).to redirect_to(new_declaration_form_path(transient_registration[:token]))
          end
        end
      end
    end
  end
end
