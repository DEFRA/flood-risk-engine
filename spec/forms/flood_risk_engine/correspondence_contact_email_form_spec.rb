require "rails_helper"
require_relative "../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe Steps::CorrespondenceContactEmailForm, type: :form do
      let(:params_key) { :correspondence_contact_email }
      let(:enrollment) { Enrollment.new }
      let(:model_class) { FloodRiskEngine::Contact }

      let(:form) { CorrespondenceContactEmailForm.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(CorrespondenceContactEmailForm) }

      let!(:email_address)    { Faker::Internet.email }
      let!(:valid_params)     { { email_address: email_address, email_address_confirmation: email_address } }

      describe "Save" do
        it "saves the email_address of the contact when email_address supplied" do
          params = { "#{form.params_key}": valid_params }

          expect(subject.redirect?).to eq(false)

          expect(form.validate(params)).to eq true

          expect(enrollment).to receive(:save).and_return(true)

          expect(form.enrollment.correspondence_contact.email_address).to be_blank

          form.save

          expect(form.enrollment.correspondence_contact.email_address).to eq email_address
        end
      end

      describe "Correspondence Contact Email" do
        let(:email_address_errors)        { subject.errors.messages[:email_address] }
        let(:email_confirmation_errors)   { subject.errors.messages[:email_address_confirmation] }

        let(:locale_errors_key) { "#{CorrespondenceContactEmailForm.locale_key}.errors" }

        it "is invalid when no email supplied" do
          params = { "#{form.params_key}": { email_address: "" } }

          expect(form.validate(params)).to eq false
          expect(email_address_errors).to eq([I18n.t("#{locale_errors_key}.email_address.blank")])
        end

        it "is invalid when no confirmation email not supplied" do
          params = { "#{form.params_key}": { email_address: email_address } }

          expect(form.validate(params)).to eq false

          expect(email_confirmation_errors).to eq([I18n.t("#{locale_errors_key}.email_address_confirmation.blank")])
        end

        it "is invalid when confirmation email does not match supplied" do
          params = { "#{form.params_key}":
                       {
                         email_address: email_address,
                         email_address_confirmation: email_address.reverse
                       }
          }

          expect(form.validate(params)).to eq false
          expect(email_confirmation_errors).to eq([I18n.t("#{locale_errors_key}.email_address_confirmation.format")])
        end

        it "is invalid  when badly formatted email supplied" do
          ["junk", "stilljunk@", "nope_stilljunk@.com"].each do |email|
            form.errors.clear

            params = { "#{form.params_key}": { email_address: email } }

            expect(form.validate(params)).to eq false

            expect(email_address_errors).to eq([I18n.t("#{locale_errors_key}.email_address.format")])
          end
        end
      end
    end
  end
end
