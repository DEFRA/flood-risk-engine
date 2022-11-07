# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe CompanyNameForm, type: :model do
    describe "#submit" do
      context "when the form is valid" do
        let(:company_name_form) { build(:company_name_form, :has_required_data) }
        let(:valid_params) do
          { token: company_name_form.token, company_name: company_name_form.company_name }
        end

        it "submits" do
          expect(company_name_form.submit(valid_params)).to be(true)
        end
      end

      context "when the form is not valid" do
        let(:company_name_form) { build(:company_name_form, :has_required_data) }
        let(:invalid_params) { { company_name: "" } }

        it "does not submit" do
          expect(company_name_form.submit(invalid_params)).to be(false)
        end
      end
    end

    include_examples "validate company_name", :company_name_form
  end
end
