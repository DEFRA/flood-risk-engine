# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "PartnerNameForms" do
    describe "GET partner_name_form_path" do
      include_examples "GET flexible form", "partner_name_form"
    end

    describe "POST partner_name_form_path" do
      let(:transient_registration) do
        create(:new_registration, workflow_state: "partner_name_form")
      end

      include_examples "POST form",
                       "partner_name_form",
                       valid_params: { full_name: "Aaron A Aaronson" },
                       invalid_params: { full_name: "" }
    end

    describe "GET back_partner_name_forms_path" do
      context "when a valid transient registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "partner_name_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the business_type form" do
            get back_partner_name_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_business_type_form_path(transient_registration[:token]))
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
            get back_partner_name_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_declaration_form_path(transient_registration[:token]))
          end
        end
      end
    end
  end
end
