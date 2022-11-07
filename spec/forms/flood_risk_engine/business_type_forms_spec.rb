# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe BusinessTypeForm, type: :model do
    describe "#submit" do
      context "when the form is valid" do
        let(:business_type_form) { build(:business_type_form, :has_required_data) }
        let(:valid_params) do
          { token: business_type_form.token, business_type: business_type_form.business_type }
        end

        it "submits" do
          expect(business_type_form.submit(valid_params)).to be(true)
        end
      end

      context "when the form is not valid" do
        let(:business_type_form) { build(:business_type_form, :has_required_data) }
        let(:invalid_params) { { business_type: "" } }

        it "does not submit" do
          expect(business_type_form.submit(invalid_params)).to be(false)
        end
      end
    end

    include_examples "validate business_type", :business_type_form
  end
end
