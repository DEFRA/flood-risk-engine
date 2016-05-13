require "rails_helper"

module FloodRiskEngine
  RSpec.describe EnrollmentPresenter, type: :presenter do
    let(:enrollment) do
      build(:enrollment,
            :with_locale_authority,
            :with_exemption,
            :with_exemption_location)
    end
    subject do
      described_class.new(enrollment)
    end
    it { is_expected.to respond_to(:organisation_type) }

    describe "#grid_reference" do
      it do
        expect(subject.grid_reference)
          .to eq(enrollment.exemption_location.grid_reference)
      end
    end

    describe "#organisation_type" do
      it do
        expect(subject.organisation_type)
          .to eq(:local_authority)
      end
    end
  end
end
