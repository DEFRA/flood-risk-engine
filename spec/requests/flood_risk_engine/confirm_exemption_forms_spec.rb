# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "ConfirmExemptionForms" do
    it_behaves_like "GET flexible form", "confirm_exemption_form"

    it_behaves_like "POST without params form", "confirm_exemption_form"

    describe "GET back_confirm_exemption_forms_path" do
      context "when a valid transient registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "confirm_exemption_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the exemption form" do
            get back_confirm_exemption_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_exemption_form_path(transient_registration[:token]))
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
            get back_confirm_exemption_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_declaration_form_path(transient_registration[:token]))
          end
        end
      end
    end
  end
end
