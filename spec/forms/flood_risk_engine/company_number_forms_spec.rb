# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe CompanyNumberForm, type: :model do
    before do
      allow_any_instance_of(DefraRuby::Validators::CompaniesHouseService).to receive(:status).and_return(:active)
    end

    describe "#submit" do
      context "when the form is valid" do
        let(:company_number_form) { build(:company_number_form, :has_required_data) }
        let(:valid_params) do
          { company_number: company_number_form.company_number }
        end

        it "should submit" do
          expect(company_number_form.submit(valid_params)).to eq(true)
        end

        context "when the token is less than 8 characters" do
          before(:each) { valid_params[:company_number] = "946107" }

          it "should increase the length" do
            company_number_form.submit(valid_params)
            expect(company_number_form.company_number).to eq("00946107")
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
