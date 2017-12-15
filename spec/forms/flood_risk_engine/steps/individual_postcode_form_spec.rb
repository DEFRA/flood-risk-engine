require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps
    describe IndividualPostcodeForm, type: :form do
      let(:params_key) { :individual_postcode }
      let(:enrollment) { FactoryBot.create(:enrollment, :with_individual) }
      let(:model_class) { FloodRiskEngine::AddressSearch }
      let(:form) { described_class.factory(enrollment) }
      let(:valid_params) { { postcode: "BS1 5AH" } }
      let(:params) { { form.params_key => valid_params } }

      subject { form }

      it_behaves_like "a form object"

      before do
        mock_ea_address_lookup_find_by_postcode
      end

      it "is not redirectable" do
        expect(form.redirect?).to_not be_truthy
      end

      describe "#save" do
        it "saves the address search including post code" do
          form.validate(params)

          expect(form.save).to eq(true)

          expect(subject.model.postcode).to eq(valid_params[:postcode])

          expect(Enrollment.last.address_search).to be_a(AddressSearch)
          expect(Enrollment.last.address_search.postcode).to eq(valid_params[:postcode])
        end
      end

      describe "#validate" do
        context "with a valid UK postcode" do
          it "validate returns true when a valid UK postcode supplied" do
            expect(form.validate(params)).to eq(true)
          end
        end

        context "with invalid params" do
          let(:invalid_params) { { form.params_key => { postcode: "BS6 " } } }

          it "validate causes an error to be added to the form" do
            form.validate(invalid_params)

            expect(
              subject.errors.messages[:postcode]
            ).to eq [
              I18n.t(
                "flood_risk_engine.validation_errors.postcode.enter_a_valid_postcode"
              )
            ]
          end

          it "validate returns false" do
            expect(form.validate(invalid_params)).to eq(false)
          end
        end

        context "with empty params" do
          let(:empty_params) { { form.params_key => { postcode: "" } } }

          it "validate returns false when a blank postcode supplied" do
            expect(form.validate(empty_params)).to eq false
          end

          it "sets the correct error message when a blank postcode supplied" do
            form.validate(empty_params)

            expect(
              subject.errors.messages[:postcode]
            ).to eq [I18n.t("flood_risk_engine.validation_errors.postcode.blank")]
          end
        end
      end
    end
  end
end
