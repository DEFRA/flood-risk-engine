# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "RegistrationCompleteForms", type: :request do
    describe "GET new_registration_complete_form_path" do
      context "when no new registration exists" do
        it "redirects to the start page" do
          get new_registration_complete_form_path("wibblewobblejellyonaplate")

          expect(response).to redirect_to(new_start_form_path)
        end
      end

      context "when a valid new registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "registration_complete_form")
        end

        context "when the workflow_state is correct" do
          it "returns a 200 status and renders the :new template" do
            get new_registration_complete_form_path(transient_registration[:token])

            expect(response).to have_http_status(200)
            expect(response).to render_template(:new)
          end
        end

        context "when the workflow_state is not correct" do
          before do
            transient_registration.update(workflow_state: "company_name_form")
          end

          it "redirects to the correct page" do
            get new_registration_complete_form_path(transient_registration[:token])

            expect(response).to redirect_to(new_company_name_form_path(transient_registration[:token]))
          end
        end
      end
    end
  end
end
