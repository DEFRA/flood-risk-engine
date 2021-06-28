# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "StartForms", type: :request do
    describe "GET new_start_form_path" do
      it "returns a 200 response and render the new template" do
        get new_start_form_path

        expect(response).to render_template(:new)
        expect(response).to have_http_status(200)
      end
    end

    describe "POST start_form_path" do
      let(:new_registration) { create(:new_registration, workflow_state: "start_form") }

      context "when a new registration token is not passed to the request" do
        let(:params) { nil }

        it "creates a NewRegistration, updates the workflow and redirects to exemption_form with a 302 status code" do
          expect(FloodRiskEngine::NewRegistration.count).to eq(0)

          post new_start_form_path(params)

          new_registration = FloodRiskEngine::NewRegistration.last

          expect(new_registration).to be_present
          expect(response).to redirect_to(new_exemption_form_path(new_registration.token))
          expect(response).to have_http_status(302)
          expect(new_registration.workflow_state).to eq("exemption_form")
        end
      end

      context "when a new registration token is passed to the request" do
        let(:params) { { token: new_registration.token } }

        it "updates the workflow and redirects to exemption_form with a 302 status code" do
          post new_start_form_path(params)

          new_registration.reload

          expect(response).to redirect_to(new_exemption_form_path(new_registration.token))
          expect(response).to have_http_status(302)
          expect(new_registration.workflow_state).to eq("exemption_form")
        end
      end
    end
  end
end
