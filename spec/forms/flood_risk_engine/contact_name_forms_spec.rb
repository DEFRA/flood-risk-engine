# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe ContactNameForm, type: :model do
    describe "#submit" do
      context "when the form is valid" do
        let(:contact_name_form) { build(:contact_name_form, :has_required_data) }
        let(:valid_params) do
          {
            token: contact_name_form.token,
            contact_name: contact_name_form.contact_name
          }
        end

        it "should submit" do
          expect(contact_name_form.submit(valid_params)).to eq(true)
        end
      end

      context "when the form is not valid" do
        let(:contact_name_form) { build(:contact_name_form, :has_required_data) }
        let(:invalid_params) do
          {
            token: "foo",
            contact_name: "**Invalid_@_Name**",
            contact_position: "**Invalid_@_Position**"
          }
        end

        it "should not submit" do
          expect(contact_name_form.submit(invalid_params)).to eq(false)
        end
      end
    end

    include_examples "validate contact name", :contact_name_form, :contact_name
  end
end
