require "rails_helper"
require_relative "../../support/shared_examples/form_objects"

module FloodRiskEngine
  RSpec.describe Steps::OrganisationTypeForm, type: :form do
    subject { described_class.factory(Enrollment.new) }
    let(:params_key) { :organisation_type }

    it_behaves_like "a form object"

    it { is_expected.to be_a(described_class) }
    it { is_expected.to respond_to(:type) }
    it { is_expected.to validate_length_of(:type) }
  end
end
