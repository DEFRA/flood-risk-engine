require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  RSpec.describe Steps::UserTypeForm, type: :form do
    let(:params_key) { :user_type }
    let(:enrollment) { Enrollment.new }
    let(:model_class) { Organisation }

    subject { described_class.factory(enrollment) }

    it_behaves_like "a form object"

    it { is_expected.to be_a(described_class) }
    it { is_expected.to respond_to(:org_type) }
    it do
      is_expected.to validate_presence_of(:org_type)
        .with_message(
          t("flood_risk_engine.enrollments.steps.user_type.errors.org_type.blank")
        )
    end

    describe ".save" do
      let(:params) { { params_key => { org_type: org_type } } }
      let(:org_type) { Organisation.org_types.keys.first }

      def validate_and_save
        expect(subject.validate(params)).to be(true)
        expect(subject.save).to be(true)
      end

      it "saves the enrollment" do
        expect(enrollment).to receive(:save).and_return(true)
        validate_and_save
      end

      it "saves the organisation" do
        expect(subject.model).to receive(:save).twice.and_return(true)
        validate_and_save
      end

      it "sets the enrollment.organisation to the correct org_type" do
        expect(subject.validate(params)).to be(true)
        validate_and_save
      end
    end
  end
end
