# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe DeclarationForm, type: :model do
    describe "#submit" do
      let(:declaration_form) { build(:declaration_form, :has_required_data) }

      context "when the form is valid" do
        let(:valid_params) do
          {
            token: declaration_form.token,
            declaration: declaration_form.declaration
          }
        end

        it "should submit" do
          expect(declaration_form.submit(valid_params)).to eq(true)
        end
      end

      context "when the declaration is blank" do
        let(:declaration_form) { build(:declaration_form, :has_required_data) }
        let(:invalid_params) do
          {
            token: declaration_form.token,
            declaration: ""
          }
        end

        it "should not submit" do
          expect(declaration_form.submit(invalid_params)).to eq(false)
        end
      end

      context "when the declaration is false" do
        let(:declaration_form) { build(:declaration_form, :has_required_data) }
        let(:invalid_params) do
          {
            token: declaration_form.token,
            declaration: false
          }
        end

        it "should not submit" do
          expect(declaration_form.submit(invalid_params)).to eq(false)
        end
      end
    end
  end
end
