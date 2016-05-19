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

      let!(:valid_params) { {} }
    end
  end
end
