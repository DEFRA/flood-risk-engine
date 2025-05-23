# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "BusinessTypeForms" do
    describe "GET business_type_form_path" do
      it_behaves_like "GET flexible form", "business_type_form"
    end

    describe "POST business_type_form_path" do
      let(:transient_registration) do
        create(:new_registration, workflow_state: "business_type_form")
      end

      it_behaves_like "POST form",
                      "business_type_form",
                      valid_params: { business_type: "limitedCompany" },
                      invalid_params: { business_type: "" }
    end

    describe "GET back_business_type_forms_path" do
      context "when a valid transient registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "business_type_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the site_grid_reference form" do
            get back_business_type_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_site_grid_reference_form_path(transient_registration[:token]))
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
            get back_business_type_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_declaration_form_path(transient_registration[:token]))
          end
        end
      end
    end
  end
end
