require "rails_helper"
require_relative "../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe Steps::LocalAuthorityPostcodeForm, type: :form do
      let(:params_key) { :local_authority_postcode }

      let(:enrollment) { create(:page_local_authority_address) }

      let(:model_class) { FloodRiskEngine::AddressSearch }

      let(:form) { LocalAuthorityPostcodeForm.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(LocalAuthorityPostcodeForm) }

      let(:valid_params) { { postcode: "BS1 5AH" } }

      before do
        mock_find_by_postcode
      end

      describe "Save" do
        include FloodRiskEngine::Engine.routes.url_helpers

        it "is not redirectable" do
          expect(form.redirect?).to_not be_truthy
        end

        let(:params) {
          { "#{form.params_key}": valid_params }
        }

        it "validate returns true when a valid UK postcode supplied", duff: true do
          expect(form.validate(params)).to eq true
        end

        it "saves the address search including post code" do
          form.validate(params)

          expect(form.save).to eq true

          expect(subject.model.postcode).to eq(valid_params[:postcode])

          expect(Enrollment.last.address_search).to be_a AddressSearch
          expect(Enrollment.last.address_search.postcode).to eq(valid_params[:postcode])
        end
      end

      context "with invalid params" do
        let(:invalid_attributes) {
          { postcode: "BS6 " }
        }

        let(:invalid_params) {
          { "#{form.params_key}": invalid_attributes }
        }

        let(:empty_params) {
          { "#{form.params_key}":  { postcode: "" } }
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
