# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "ContactEmailForms", type: :request do
    describe "GET contact_email_form_path" do
      include_examples "GET flexible form", "contact_email_form"
    end

    describe "POST contact_email_form_path" do
      let(:transient_registration) do
        create(:new_registration, workflow_state: "contact_email_form")
      end

      include_examples "POST form",
                       "contact_email_form",
                       valid_params: { contact_email: "valid@example.com",
                                       confirmed_email: "valid@example.com" },
                       invalid_params: { contact_email: "foo" }
    end

    describe "GET back_contact_email_forms_path" do
      context "when a valid transient registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "contact_email_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the contact_phone form" do
            get back_contact_email_forms_path(transient_registration[:token])

            expect(response).to have_http_status(302)
            expect(response).to redirect_to(new_contact_phone_form_path(transient_registration[:token]))
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
            get back_contact_email_forms_path(transient_registration[:token])

            expect(response).to have_http_status(302)
            expect(response).to redirect_to(new_declaration_form_path(transient_registration[:token]))
          end
        end
      end
    end
  end
end
