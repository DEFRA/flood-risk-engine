# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "DeclarationForms" do
    describe "GET declaration_form_path" do
      it_behaves_like "GET locked-in form", "declaration_form"
    end

    describe "POST declaration_form_path" do
      it_behaves_like "POST without params form", "declaration_form"
    end

    describe "GET back_declaration_forms_path" do
      context "when a valid transient registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "declaration_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the check_your_answers form" do
            get back_declaration_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_check_your_answers_form_path(transient_registration[:token]))
          end
        end
      end

      context "when the transient registration is in the wrong state" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "company_name_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the correct form for the state" do
            get back_declaration_forms_path(transient_registration[:token])

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_company_name_form_path(transient_registration[:token]))
          end
        end
      end
    end
  end
end
