# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe CompanyPostcodeForm, type: :model do
    describe "#submit" do
      context "when the form is valid" do
        let(:company_postcode_form) { build(:company_postcode_form, :has_required_data) }
        let(:valid_params) do
          { token: company_postcode_form.token, temp_company_postcode: company_postcode_form.temp_company_postcode }
        end

        it "submits" do
          expect(company_postcode_form.submit(valid_params)).to be(true)
        end
      end

      context "when the form is not valid" do
        let(:company_postcode_form) { build(:company_postcode_form, :has_required_data) }
        let(:invalid_params) { { temp_company_postcode: "" } }

        it "does not submit" do
          expect(company_postcode_form.submit(invalid_params)).to be(false)
        end
      end
    end

    include_examples "validate postcode", :company_postcode_form, :temp_company_postcode
  end
end
