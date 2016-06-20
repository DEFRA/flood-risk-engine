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
    end
  end
end
