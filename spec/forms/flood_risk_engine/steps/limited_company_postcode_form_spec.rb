require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe Steps::LimitedCompanyPostcodeForm, type: :form do
      let(:params_key) { :limited_company_postcode }

      let(:enrollment) { create(:page_limited_company_postcode) }

      let(:model_class) { FloodRiskEngine::AddressSearch }

      let(:form) { LimitedCompanyPostcodeForm.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(LimitedCompanyPostcodeForm) }

      let(:valid_params) { { postcode: "BS1 5AH" } }

      describe "Save" do
        it "is not redirectable" do
          expect(form.redirect?).to_not be_truthy
        end

        let(:params) {
          { "#{form.params_key}": valid_params }
        }

        it "validate returns true when a valid UK postcode supplied" do
          VCR.use_cassette("address_lookup_valid_postcode") do
            expect(form.validate(params)).to eq true
          end
        end

        it "saves the address search including post code" do
          VCR.use_cassette("address_lookup_valid_postcode") do
            form.validate(params)

            expect(form.save).to eq true

            expect(subject.model.postcode).to eq(valid_params[:postcode])

            expect(Enrollment.last.address_search).to be_a AddressSearch
            expect(Enrollment.last.address_search.postcode).to eq(valid_params[:postcode])
          end
        end
      end

      context "with invalid params" do
        let(:valid_postcode_no_matches) {
          { "#{form.params_key}": { postcode: "BS1 1ZZ" } }
        }

        it "is invalid when valid Postcode supplied but Address Service finds no matches", duff: true do
          VCR.use_cassette("address_lookup_no_matches_postcode") do
            expect(form.validate(valid_postcode_no_matches)).to eq false

            expect(
              form.errors.messages[:postcode]
            ).to eq [I18n.t("flood_risk_engine.validation_errors.postcode.no_addresses_found")]
          end
        end

        let(:invalid_attributes) {
          { postcode: "BS6 " }
        }

        let(:invalid_params) {
          { "#{form.params_key}": invalid_attributes }
        }

        let(:empty_params) {
          { "#{form.params_key}": { postcode: "" } }
        }

        it "validate returns false when a blank postcode supplied" do
          expect(form.validate(empty_params)).to eq false
        end

        it "validate returns false when an invalid UK postcode supplied" do
          expect(form.validate(invalid_params)).to eq false
        end

        it "sets the correct error message when a blank postcode supplied" do
          form.validate(empty_params)

          expect(
            subject.errors.messages[:postcode]
          ).to eq [I18n.t("flood_risk_engine.validation_errors.postcode.blank")]
        end

        it "validate returns false when an invalid UK postcode supplied" do
          form.validate(invalid_params)

          expect(
            subject.errors.messages[:postcode]
          ).to eq [I18n.t("flood_risk_engine.validation_errors.postcode.enter_a_valid_postcode")]
        end
      end
    end
  end
end
