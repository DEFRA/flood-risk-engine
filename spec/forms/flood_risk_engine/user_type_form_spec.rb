require "rails_helper"
require_relative "../../support/shared_examples/form_objects"

module FloodRiskEngine
  RSpec.describe Steps::UserTypeForm, type: :form do
    let(:params_key) { :user_type }
    let(:enrollment) { Enrollment.new }
    let(:model_class) { Organisation }

    subject { described_class.factory(enrollment) }

    it_behaves_like "a form object"

    it { is_expected.to be_a(described_class) }
    it { is_expected.to respond_to(:type) }
    it { is_expected.to validate_presence_of(:type) }

    describe "#save" do
      it "saves the enrollment.organisation with the correct STI type" do
        sti_type = FloodRiskEngine::OrganisationTypes::Individual
        params = { params_key => { type: sti_type.to_s }}

        expect(enrollment).to receive(:save).and_return(true) # stub save

        subject.validate(params)
        subject.save

        expect(enrollment.organisation).to be_a(sti_type)
      end
    end
  end
end
