require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe Steps::LimitedCompanyNumberForm, type: :form do
      let(:params_key) { :limited_company_number }

      let(:enrollment) { create(:page_limited_company_number) }

      let(:model_class) { FloodRiskEngine::Organisation } # needed for  it_behaves_like "a form object"

      let(:form) { LimitedCompanyNumberForm.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(LimitedCompanyNumberForm) }

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
          ).to eq [I18n.t("#{LimitedCompanyNumberForm.locale_key}.errors.blank")]
        end

        it "form contains errors" do
          form.validate(invalid_attributes)

          expect(
            form.errors.messages[:registration_number]
          ).to eq [I18n.t("#{LimitedCompanyNumberForm.locale_key}.errors.invalid_html")]
        end
      end
    end
  end
end
