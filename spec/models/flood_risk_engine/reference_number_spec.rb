require "rails_helper"

module FloodRiskEngine
  RSpec.describe ReferenceNumber, type: :model do
    let(:reference_number) { described_class.create }
    let(:increment) { reference_number.increment }
    let(:number) { reference_number.number }

    describe "#number" do
      it "should be prefixed" do
        expect(number).to match(/^#{described_class::PREFIX}/)
      end

      it "should contain increment" do
        expect(number).to match(increment)
      end

      it "should be padded" do
        expect(number).to match(/#{described_class::PADDING}#{increment}/)
      end

      it "should be at least minimum length" do
        expect(number.length).to be >= described_class::MINIMUM_LENGTH
      end
    end

    describe "#increment" do
      it "should be the id plus the offset" do
        expected = reference_number.id + described_class::OFFSET
        expect(increment).to eq(expected.to_s)
      end
    end
  end
end
