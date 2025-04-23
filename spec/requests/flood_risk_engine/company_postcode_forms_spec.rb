# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "CompanyPostcodeForms" do
    describe "GET company_postcode_form_path" do
      it_behaves_like "GET flexible form", "company_postcode_form"
    end

    describe "POST company_postcode_form_path" do
      let(:transient_registration) do
        create(:new_registration, workflow_state: "company_postcode_form")
      end

      it_behaves_like "POST form",
                      "company_postcode_form",
                      valid_params: { temp_company_postcode: "BS1 5AH" },
                      invalid_params: { temp_company_postcode: "" }

      context "with an invalid postcode" do
        let(:invalid_params) { { temp_company_postcode: "BSA 51H" } }

        before { post_form_with_params("company_postcode_form", transient_registration.token, invalid_params) }

        it { expect(response.body).to include "Enter a valid postcode" }
      end
    end

    describe "GET back_company_postcode_forms_path" do
      context "when a valid transient registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "company_postcode_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the company_name form" do
            get back_company_postcode_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_company_name_form_path(transient_registration[:token]))
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
            get back_company_postcode_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_declaration_form_path(transient_registration[:token]))
          end
        end
      end
    end
  end
end
