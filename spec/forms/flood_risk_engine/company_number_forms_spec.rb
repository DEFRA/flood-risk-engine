# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe CompanyNumberForm, type: :model do
    describe "#submit" do
      context "when the form is valid" do
        let(:company_number_form) { build(:company_number_form, :has_required_data) }
        let(:valid_params) do
          { token: company_number_form.token, company_number: company_number_form.company_number }
        end

        it "should submit" do
          expect(company_number_form.submit(valid_params)).to eq(true)
        end

        context "when the token is less than 8 characters" do
          before(:each) { valid_params[:company_number] = "9764739" }

          it "should increase the length" do
            company_number_form.submit(valid_params)
            expect(company_number_form.company_number).to eq("09764739")
          end

          it "should submit" do
            expect(company_number_form.submit(valid_params)).to eq(true)
          end
        end
      end

      context "when the form is not valid" do
        let(:company_number_form) { build(:company_number_form, :has_required_data) }
        let(:invalid_params) { { company_number: "" } }

        it "should not submit" do
          expect(company_number_form.submit(invalid_params)).to eq(false)
        end
      end
    end

    include_examples "validate company_number", :company_number_form
  end
end
