require "rails_helper"
require_relative "../../support/shared_examples/form_objects"

module FloodRiskEngine
  RSpec.describe Steps::GridReferenceForm, type: :form do
    let(:params_key) { :activity_location }
    let(:enrollment) { Enrollment.new }
    let(:model_class) { Location }

    subject { described_class.factory(enrollment) }

    it_behaves_like "a form object"

    it { is_expected.to be_a(described_class) }
    it { is_expected.to respond_to(:grid_reference) }
    it { is_expected.to validate_length_of(:grid_reference) }

    describe "#save" do
    end
  end
end
