# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe Exemption do
    it { is_expected.to be_valid }
    it { is_expected.to have_many(:enrollment_exemptions).dependent(:restrict_with_exception) }
    it { is_expected.to have_many(:enrollments).through(:enrollment_exemptions) }

    describe ".code_number" do
      let(:number) { 44 }

      it "is updated on save" do
        exemption = described_class.create(code: "foo#{number}", summary: "foo")
        expect(exemption.code_number).to eq(number)
      end
    end

    describe ".long_dredging?" do
      context "with a long dredging exemption" do
        let(:exemption) { FactoryBot.create(:exemption, code: "FRA23") }

        it "is true" do
          expect(exemption.long_dredging?).to be_truthy
        end
      end

      context "with a standard exemption" do
        let(:exemption) { FactoryBot.create(:exemption) }

        it "is false" do
          expect(exemption.long_dredging?).to be_falsey
        end
      end
    end
  end
end
