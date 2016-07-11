require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe ConfirmationForm, type: :form do
      let(:params_key) { :confirmation }

      let(:enrollment) { create(:page_confirmation) }

      let(:model_class) { FloodRiskEngine::Enrollment }

      let(:form) { ConfirmationForm.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(ConfirmationForm) }

      describe "Save" do
        include FloodRiskEngine::Engine.routes.url_helpers

        it "is not redirectable" do
          expect(form.redirect?).to_not be_truthy
        end

        let(:params) {
          { "#{form.params_key}": {} }
        }

        it "no params to validate so validate returns true " do
          expect(form.validate(params)).to eq true
        end

        it "no params to save so save returns true" do
          expect(form.save).to eq true
        end
      end

      describe "#email" do
        context "there is no enrollment secondary contact" do
          it "returns a single email address" do
            expect(form.email).to eq(enrollment.correspondence_contact.email_address)
          end
        end
        context "there is an enrollment secondary contact" do
          let(:enrollment) { create(:page_confirmation, :with_secondary_contact) }
          it "returns two email addresses in a sentence" do
            expected_sentence = [
              enrollment.correspondence_contact.email_address,
              " and ",
              enrollment.secondary_contact.email_address
            ].join

            expect(form.email).to eq(expected_sentence)
          end
        end
      end
    end
  end
end
