require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe Steps::IndividualNameForm, type: :form do
      # These needed for it_behaves_like "a form object"
      let(:params_key) { :individual_name }
      let(:model_class) { FloodRiskEngine::Organisation }

      let(:enrollment) { create(:page_individual_name) }
      let(:form) { IndividualNameForm.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(IndividualNameForm) }

      it {
        is_expected.to validate_presence_of(:name)
          .with_message(t("#{IndividualNameForm.locale_key}.errors.name.blank"))
      }

      describe "#config" do
        it "returns a default max name length " do
          expect(IndividualNameForm.max_length).to eq 170
        end

        it "enables max name length to be configured " do
          FloodRiskEngine.config.maximum_individual_name_length = 5

          expect(IndividualNameForm.max_length).to eq 5
        end

        after(:all) do
          FloodRiskEngine.config.maximum_individual_name_length = nil
        end
      end

      describe "#save" do
        it "saves the name of the individual when supplied" do
          params = { "#{form.params_key}": { name: "Michael Bisping" } }

          expect(subject.redirect?).to eq(false)

          expect(form.validate(params)).to eq true
          expect(form.save).to eq true

          expect(form.enrollment.organisation.name).to eq params[form.params_key][:name]
        end
      end

      describe "#validate" do
        it "does not validate when no name supplied" do
          params = { "#{form.params_key}": { name: "" } }

          expect(form.validate(params)).to eq false
          expect(subject.errors.messages[:name])
            .to eq([I18n.t("#{IndividualNameForm.locale_key}.errors.name.blank")])
        end

        it "does not validate when name with unacceptable chars" do
          params = { "#{form.params_key}": { name: "Jon *& Jones" } }

          expect(form.validate(params)).to eq false
          expect(subject.errors.messages[:name])
            .to eq([I18n.t("flood_risk_engine.validation_errors.name.invalid")])
        end

        it "does not validate when name supplied is too long" do
          name = "this will is will blow" + "a" * IndividualNameForm.max_length
          params = { "#{form.params_key}": { name: name } }

          expect(form.validate(params)).to eq false
          expect(
            subject.errors.messages[:name]
          ).to eq(
            [
              I18n.t("#{IndividualNameForm.locale_key}.errors.name.too_long",
                     max_length: IndividualNameForm.max_length)
            ]
          )
        end
      end
    end
  end
end
