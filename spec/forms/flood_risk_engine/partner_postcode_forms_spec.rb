# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe PartnerPostcodeForm, type: :model do
    describe "#submit" do
      context "when the form is valid" do
        let(:partner_postcode_form) { build(:partner_postcode_form, :has_required_data) }
        let(:valid_params) do
          { token: partner_postcode_form.token, temp_postcode: "BS1 5AH" }
        end

        it "submits" do
          expect(partner_postcode_form.submit(valid_params)).to be(true)
        end
      end

      context "when the form is not valid" do
        let(:partner_postcode_form) { build(:partner_postcode_form, :has_required_data) }
        let(:invalid_params) { { temp_postcode: "" } }

        it "does not submit" do
          expect(partner_postcode_form.submit(invalid_params)).to be(false)
        end
      end
    end
  end
end
