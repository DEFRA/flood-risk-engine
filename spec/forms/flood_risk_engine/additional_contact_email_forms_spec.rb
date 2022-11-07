# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe AdditionalContactEmailForm, type: :model do
    describe "#submit" do
      context "when the form is valid" do
        let(:additional_contact_email_form) { build(:additional_contact_email_form, :has_required_data) }
        let(:valid_params) do
          {
            token: additional_contact_email_form.token,
            additional_contact_email: additional_contact_email_form.additional_contact_email,
            confirmed_email: additional_contact_email_form.additional_contact_email
          }
        end

        it "submits" do
          expect(additional_contact_email_form.submit(ActionController::Parameters.new(valid_params))).to be(true)
        end
      end

      context "when the form is not valid" do
        let(:additional_contact_email_form) { build(:additional_contact_email_form, :has_required_data) }
        let(:invalid_params) do
          {
            token: "foo",
            additional_contact_email: "foo"
          }
        end

        it "does not submit" do
          expect(additional_contact_email_form.submit(ActionController::Parameters.new(invalid_params))).to be(false)
        end
      end
    end

    include_examples "validate email", :additional_contact_email_form, :additional_contact_email

    context "when a valid transient registration exists" do
      let(:additional_contact_email_form) { build(:additional_contact_email_form, :has_required_data) }

      describe "#confirmed_email" do
        context "when a confirmed_email meets the requirements" do
          it "is valid" do
            expect(additional_contact_email_form).to be_valid
          end
        end

        context "when a confirmed_email does not match the additional_contact_email" do
          before { additional_contact_email_form.confirmed_email = "no_matchy@example.com" }

          it "is not valid" do
            expect(additional_contact_email_form).not_to be_valid
          end
        end
      end
    end
  end
end
