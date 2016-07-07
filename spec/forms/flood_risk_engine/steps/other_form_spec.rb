require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe OtherForm, type: :form do
      let(:params_key) { :other }
      let(:enrollment) { Enrollment.new }
      let(:model_class) { FloodRiskEngine::Organisation }
      let(:name) { Faker::Company.name }
      let!(:i18n_scope) { described_class.locale_key }
      let(:form) { described_class.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it "has redirect? as false" do
        expect(subject.redirect?).to eq(false)
      end

      describe "#save" do
        it "saves the name of the local authority when name supplied" do
          expect(enrollment).to receive(:save).and_return(true)
          params = { form.params_key => { name: name } }

          form.validate(params)
          form.save

          expect(form.enrollment.organisation.name).to eq(name)
        end
      end

      describe "#validate" do
        it "does not validate when no name supplied" do
          params = { form.params_key => { name: "" } }

          expect(form.validate(params)).to eq(false)
          expect(subject.errors.messages[:name])
            .to eq([I18n.t(".errors.name.blank", scope: i18n_scope)])
        end

        it "validates when name has an ampersand" do
          params = { form.params_key => { name: "Ruby & White" } }

          expect(form.validate(params)).to eq true
        end

        it "does not validate when name with unacceptable chars" do
          params = { form.params_key => { name: "bristol ^ " } }

          expect(form.validate(params)).to eq(false)
          expect(subject.errors.messages[:name])
            .to eq([I18n.t("#{OtherForm.locale_key}.errors.name.invalid")])
        end

        it "does not validate when name supplied is too long" do
          name = "bb" + ("a" * described_class.max_length)
          params = { form.params_key => { name: name } }

          expect(form.validate(params)).to eq(false)
          expect(
            subject.errors.messages[:name]
          ).to eq(
            [
              I18n.t(
                ".errors.name.too_long",
                max: described_class.max_length,
                scope: i18n_scope
              )
            ]
          )
        end
      end
    end
  end
end
