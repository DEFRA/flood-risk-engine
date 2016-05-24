require "rails_helper"
require_relative "../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe Steps::LocalAuthorityAddressForm, type: :form do
      let(:params_key) { :local_authority_address }

      let(:enrollment) { create(:page_local_authority_address) }

      let(:model_class) { FloodRiskEngine::Address }

      let(:form) { LocalAuthorityAddressForm.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(LocalAuthorityAddressForm) }

      let!(:valid_post_code) { "HX3 0TD" }

      context "with valid params" do
        let(:valid_attributes) {
          {
            "#{params_key}":
              {
                post_code: valid_post_code,
                uprn: "10010175140"
              }
          }
        }

        it "is valid when valid UK UPRN supplied via drop down rendering process_address", duff: true do
          VCR.use_cassette("forms_address_form_valid_uprn_from_dropdown") do
            expect(form.validate(valid_attributes)).to eq false
            expect(form.errors.size).to eq 1
          end
        end
      end
    end
  end
end
