# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe ContactEmailForm, type: :model do
    describe "#submit" do
      context "when the form is valid" do
        let(:contact_email_form) { build(:contact_email_form, :has_required_data) }
        let(:valid_params) do
          {
            token: contact_email_form.token,
            contact_email: contact_email_form.contact_email,
            confirmed_email: contact_email_form.contact_email
          }
        end

        it "should submit" do
          expect(contact_email_form.submit(ActionController::Parameters.new(valid_params))).to eq(true)
        end
      end

      context "when the form is not valid" do
        let(:contact_email_form) { build(:contact_email_form, :has_required_data) }
        let(:invalid_params) do
          {
            token: "foo",
            contact_email: "foo"
          }
        end

        it "should not submit" do
          expect(contact_email_form.submit(ActionController::Parameters.new(invalid_params))).to eq(false)
        end
      end
    end

    include_examples "validate email", :contact_email_form, :contact_email

    context "when a valid transient registration exists" do
      let(:contact_email_form) { build(:contact_email_form, :has_required_data) }

      describe "#confirmed_email" do
        context "when a confirmed_email meets the requirements" do
          it "is valid" do
            expect(contact_email_form).to be_valid
          end
        end

        context "when a confirmed_email does not match the contact_email" do
          before(:each) { contact_email_form.confirmed_email = "no_matchy@example.com" }

          it "is not valid" do
            expect(contact_email_form).to_not be_valid
          end
        end
      end
    end
  end
end
