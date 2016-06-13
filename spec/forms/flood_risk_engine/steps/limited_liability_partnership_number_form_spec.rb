require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe Steps::LimitedLiabilityPartnershipNumberForm, type: :form do
      let(:params_key) { :limited_liability_partnership_number }

      let(:enrollment) { create(:page_limited_liability_partnership) }

      let(:model_class) { FloodRiskEngine::Organisation }

      let(:form) { LimitedLiabilityPartnershipNumberForm.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(LimitedLiabilityPartnershipNumberForm) }

      it "is not redirectable" do
        expect(form.redirect?).to_not be_truthy
      end

      let(:company_number) { "01234567" }

      context "with valid params" do
        let(:valid_attributes) {
          { "#{form.params_key}": { registration_number: company_number } }
        }

        it "form validate returns true" do
          expect(form.validate(valid_attributes)).to eq true
        end

        describe "Save" do
          it "saves a valid company_number on enrollment's organisation" do
            form.validate(valid_attributes)
            expect(form.save).to eq true

            expect(form.model.registration_number).to eq company_number

            expect(Enrollment.last.organisation.registration_number).to eq company_number
          end
        end
      end

      context "with invalid params" do
        let(:invalid_attributes) {
          { "#{form.params_key}": { registration_number: "4567" } }
        }

        it "form validate returns false" do
          expect(form.validate(invalid_attributes)).to eq false
        end

        it "form contains error realted to blank entry" do
          form.validate("#{form.params_key}": { registration_number: nil })

          expect(
            subject.errors.messages[:registration_number]
          ).to eq [I18n.t("#{LimitedLiabilityPartnershipNumberForm.locale_key}.errors.blank")]
        end

        it "form contains errors" do
          form.validate(invalid_attributes)
          expect(
            form.errors.messages[:registration_number]
          ).to eq [I18n.t("ea.validation_errors.companies_house_number.registration_number.invalid_html")]
        end
      end
    end
  end
end
