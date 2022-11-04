# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "SiteGridReferenceForms" do
    describe "GET site_grid_reference_form_path" do
      include_examples "GET flexible form", "site_grid_reference_form"
    end

    describe "POST site_grid_reference_form_path" do
      let(:transient_registration) do
        create(:new_registration, workflow_state: "site_grid_reference_form")
      end

      include_examples "POST form",
                       "site_grid_reference_form",
                       valid_params: {
                         temp_grid_reference: "ST 5813272695",
                         temp_site_description: "foo",
                         dredging_length: "99"
                       },
                       invalid_params: { temp_grid_reference: nil }
    end

    describe "GET back_site_grid_reference_forms_path" do
      context "when a valid transient registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "site_grid_reference_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the confirm_exemption form" do
            get back_site_grid_reference_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_confirm_exemption_form_path(transient_registration[:token]))
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
            get back_site_grid_reference_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_declaration_form_path(transient_registration[:token]))
          end
        end
      end
    end
  end
end
