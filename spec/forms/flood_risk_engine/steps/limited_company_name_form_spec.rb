require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe Steps::LimitedCompanyNameForm, type: :form do
      # These needed for it_behaves_like "a form object"
      let(:params_key) { :limited_company_name }
      let(:model_class) { FloodRiskEngine::Organisation }

      let(:enrollment) { create(:page_limited_company_name) }
      let(:form) { LimitedCompanyNameForm.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(LimitedCompanyNameForm) }

      it {
        is_expected.to validate_presence_of(:name)
          .with_message(t("#{LimitedCompanyNameForm.locale_key}.errors.name.blank"))
      }

      describe "#save" do
        it "saves the name of the limited company when supplied" do
          params = { "#{form.params_key}": { name: "Bodge It and Scarper Ltd" } }

          expect(subject.redirect?).to eq(false)

          expect(form.validate(params)).to eq true
          expect(form.save).to eq true

          expect(form.enrollment.organisation.name).to eq params[form.params_key][:name]
        end
      end

      describe "#invalid" do
        it "does not validate when no name supplied" do
          params = { "#{form.params_key}": { name: "" } }

          expect(form.validate(params)).to eq false
          expect(subject.errors.messages[:name])
            .to eq([I18n.t("#{LimitedCompanyNameForm.locale_key}.errors.name.blank")])
        end

        it "does not validate when name with unacceptable chars" do
          params = { "#{form.params_key}": { name: "bristol ^ Ltd " } }

          expect(form.validate(params)).to eq false
          expect(subject.errors.messages[:name])
            .to eq([I18n.t("ea.validation_errors.companies_house_name.name.invalid")])
        end

        it "does not validate when name supplied is too long" do
          name = "this will is will blow" + "a" * LimitedCompanyNameForm.max_length
          params = { "#{form.params_key}": { name: name } }

          expect(form.validate(params)).to eq false
          expect(
            subject.errors.messages[:name]
          ).to eq(
            [
              I18n.t("#{LimitedCompanyNameForm.locale_key}.errors.name.too_long",
                     max_length: LimitedCompanyNameForm.max_length)
            ]
          )
        end
      end
    end
  end
end
