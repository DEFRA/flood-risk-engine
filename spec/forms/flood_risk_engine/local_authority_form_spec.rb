require "rails_helper"
require_relative "../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe Steps::LocalAuthorityForm, type: :form do
      let(:params_key) { :local_authority }
      let(:enrollment) { Enrollment.new }
      let(:model_class) { FloodRiskEngine::Organisation }

      let(:form) { LocalAuthorityForm.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(LocalAuthorityForm) }

      it {
        is_expected.to validate_presence_of(:name)
          .with_message(t("#{LocalAuthorityForm.locale_key}.errors.name.blank"))
      }

      describe "#save" do
        it "saves the name of the local authority when name supplied" do
          expect(enrollment).to receive(:save).and_return(true)
          params = { "#{form.params_key}": { name: "Bodge It and Scarper Ltd" } }

          expect(subject.redirect?).to eq(false)

          form.validate(params)
          form.save

          expect(form.enrollment.organisation.name).to eq params[form.params_key][:name]
        end

        it "does not validate when no name supplied" do
          params = { "#{form.params_key}": { name: "" } }

          expect(form.validate(params)).to eq false
          expect(subject.errors.messages[:name])
            .to eq([I18n.t("#{LocalAuthorityForm.locale_key}.errors.name.blank")])
        end

        it "does not validate when name with unacceptable chars" do
          params = { "#{form.params_key}": { name: "bristol *& " } }

          expect(form.validate(params)).to eq false
          expect(subject.errors.messages[:name])
            .to eq([I18n.t("flood_risk_engine.validation_errors.name.invalid")])
        end

        it "does not validate when name supplied is too long" do
          name = "this will is will blow" + "a" * LocalAuthorityForm.name_max_length
          params = { "#{form.params_key}": { name: name } }

          expect(form.validate(params)).to eq false
          expect(subject.errors.messages[:name])
            .to eq([I18n.t("#{LocalAuthorityForm.locale_key}.errors.name.too_long")])
        end
      end
    end
  end
end
