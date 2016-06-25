require "rails_helper"

module FloodRiskEngine
  RSpec.describe EnrollmentExemption, type: :model do
    it { is_expected.to be_valid }
    it { is_expected.to respond_to(:expires_at) }
    it { is_expected.to respond_to(:valid_from) }
    it { is_expected.to have_many(:comments) }

    context "Factories" do
      it "has a valid factory" do
        expect(build(:enrollment_exemption)).to be_valid
      end
    end
  end
end
