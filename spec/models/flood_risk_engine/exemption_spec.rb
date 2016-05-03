require "rails_helper"

module FloodRiskEngine
  RSpec.describe Exemption, type: :model do
    it { is_expected.to be_valid }
    it { is_expected.to have_many(:enrollment_exemptions).dependent(:restrict_with_exception) }
    it { is_expected.to have_many(:enrollments).through(:enrollment_exemptions) }

    describe ".code_number" do
      let(:number) { 44 }

      it "should be updated on save" do
        exemption = described_class.create(code: "foo#{number}", summary: "foo")
        expect(exemption.code_number).to eq(number)
      end
    end
  end
end
