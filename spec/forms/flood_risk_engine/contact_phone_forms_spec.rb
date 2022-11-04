# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe ContactPhoneForm, type: :model do
    describe "#submit" do
      context "when the form is valid" do
        let(:contact_phone_form) { build(:contact_phone_form, :has_required_data) }
        let(:valid_params) do
          {
            token: contact_phone_form.token,
            contact_phone: contact_phone_form.contact_phone
          }
        end

        it "submits" do
          expect(contact_phone_form.submit(valid_params)).to be(true)
        end
      end

      context "when the form is not valid" do
        let(:contact_phone_form) { build(:contact_phone_form, :has_required_data) }
        let(:invalid_params) do
          {
            token: "foo",
            contact_phone: "foo"
          }
        end

        it "does not submit" do
          expect(contact_phone_form.submit(invalid_params)).to be(false)
        end
      end
    end

    include_examples "validate contact_phone", :contact_phone_form
  end
end
