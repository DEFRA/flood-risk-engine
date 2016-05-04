require "rails_helper"
require_relative "../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe Steps::CorrespondenceContactNameForm, type: :form do
      let(:params_key) { :correspondence_contact_name }
      let(:enrollment) { Enrollment.new }
      let(:model_class) { FloodRiskEngine::Contact }

      let(:form) { CorrespondenceContactNameForm.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(CorrespondenceContactNameForm) }

      it "supplied details of name max length" do
        expect(CorrespondenceContactNameForm.respond_to?(:name_max_length)).to eq true
        expect(CorrespondenceContactNameForm.name_max_length).to be_a Fixnum
      end

      let!(:full_name)    { Faker::Name.name }
      let!(:position)     { Faker::Company.profession }
      let!(:valid_params) { { full_name: full_name } }

      describe "Save" do
        it "saves the name of the contact when name supplied" do
          params = { "#{form.params_key}": valid_params }

          expect(subject.redirect?).to eq(false)

          expect(form.validate(params)).to eq true

          expect(enrollment).to receive(:save).and_return(true)
          form.save

          expect(form.enrollment.correspondence_contact.full_name).to eq full_name
        end

        it "saves optional position on contact when supplied" do
          params = { "#{form.params_key}": valid_params.merge(position: position) }

          expect(subject.redirect?).to eq(false)

          expect(form.validate(params)).to eq true

          expect(enrollment).to receive(:save).and_return(true)
          form.save

          expect(form.enrollment.correspondence_contact.full_name).to eq full_name
          expect(form.enrollment.correspondence_contact.position).to eq position
        end
      end

      describe "Validation" do
        let(:full_name_errors)    { subject.errors.messages[:full_name] }
        let(:position_errors)     { subject.errors.messages[:position] }

        let(:locale_errors_key) { "#{CorrespondenceContactNameForm.locale_key}.errors" }

        let(:name_max_length)     { CorrespondenceContactNameForm.name_max_length }
        let(:position_max_length) { CorrespondenceContactNameForm.position_max_length }

        it "does not validate when no name supplied" do
          params = { "#{form.params_key}": { full_name: "" } }

          expect(form.validate(params)).to eq false
          expect(full_name_errors).to eq([I18n.t("#{locale_errors_key}.full_name.blank")])
        end

        it "does not validate when name supplied is too long" do
          name = "Mr This Will Blow" + "a" * name_max_length
          params = { "#{form.params_key}": { full_name: name } }

          expect(form.validate(params)).to eq false
          expect(full_name_errors).to eq(
            [I18n.t("#{locale_errors_key}.full_name.too_long", max_length: name_max_length)]
          )
        end

        it "does not validate when name with unacceptable chars" do
          params = { "#{form.params_key}": { full_name: "Mr * 123" } }

          expect(form.validate(params)).to eq false
          expect(full_name_errors).to eq([I18n.t("flood_risk_engine.validation_errors.full_name.invalid")])
        end

        it "does not validate if name is less than one word" do
          [" Joe", "Joe", "Joe  "].each do |bad|
            form.errors.clear
            params = { "#{form.params_key}": { full_name: bad } }
            expect(form.validate(params)).to eq false
            expect(full_name_errors).to eq([I18n.t("flood_risk_engine.validation_errors.full_name.too_few")])
          end
        end

        it "does not validate when job title provided but has unacceptable chars" do
          params = { "#{form.params_key}": valid_params.merge(position: "& a role that s*cks") }

          expect(form.validate(params)).to eq false

          expect(full_name_errors).to be_nil
          expect(position_errors).to eq([I18n.t("flood_risk_engine.validation_errors.position.invalid")])
        end

        it "does not validate when job title provided but is too long" do
          params = { "#{form.params_key}": valid_params.merge(position: "role" + "a" * position_max_length) }

          expect(form.validate(params)).to eq false

          expect(full_name_errors).to be_nil
          expect(position_errors).to eq(
            [I18n.t("#{locale_errors_key}.position.too_long",
                    max_length: position_max_length)]
          )
        end
      end
    end
  end
end
