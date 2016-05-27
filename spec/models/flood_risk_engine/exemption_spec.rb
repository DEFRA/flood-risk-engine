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

    describe ".long_dredging?" do
      context "with a long dredging exemption" do
        let(:exemption) { FactoryGirl.create(:exemption, code: "FRA23") }

        it "should be true" do
          expect(exemption.long_dredging?).to be_truthy
        end
      end

      context "with a standard exemption" do
        let(:exemption) { FactoryGirl.create(:exemption) }

        it "should be false" do
          expect(exemption.long_dredging?).to be_falsey
        end
      end
    end
  end
end
