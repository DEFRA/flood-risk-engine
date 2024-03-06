# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "Errors" do

    before do
      env_config = Rails.application.env_config
      allow(env_config).to receive(:[]).with("action_dispatch.show_exceptions").and_return(true)
      allow(env_config).to receive(:[]).with("action_dispatch.show_detailed_exceptions").and_return(false)
    end

    shared_examples "not found" do |path|
      before { get path }

      it "responds with HTTP 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "renders a HTML error page" do
        expect(response.headers["Content-Type"]).to include("text/html")
      end

      it "includes expected error text" do
        expect(response.body).to match(/If you typed the web address/)
      end
    end

    describe "explicit error paths" do
      context "when a matching error template exists" do
        %w[401 403 404 422].each do |code|
          it "responds with a status of #{code} and renders the error_#{code} template" do
            get error_path(code)

            expect(response.code).to eq(code)
            expect(response).to render_template("error_#{code}")
          end
        end
      end

      context "when no matching error template exists" do
        it "renders the generic error template" do
          get error_path("601")

          expect(response).to have_http_status(:internal_server_error)
          expect(response).to render_template(:error_generic)
        end
      end
    end

    describe "internal redirects to error pages" do
      context "when the requested route does not exist" do
        context "when the requested route format is not specified" do
          it_behaves_like "not found", "/this-page-does-not-exist"
        end

        context "when the requested route format is html" do
          it_behaves_like "not found", "/this-page-does-not-exist.html"
        end

        context "when the requested route format is not html" do
          it_behaves_like "not found", "/this-page-does-not-exist.xml"
        end
      end
    end

    context "when an unhandled internal system error occurs (500)" do

      let(:start_forms_controller) { FloodRiskEngine::StartFormsController.new }

      before do
        allow(FloodRiskEngine::StartFormsController).to receive(:new).and_return(start_forms_controller)
        allow(start_forms_controller).to receive(:create).and_raise(StandardError)
      end

      it do
        post start_forms_path

        expect(response).to redirect_to error_path("500")
      end
    end
  end
end
