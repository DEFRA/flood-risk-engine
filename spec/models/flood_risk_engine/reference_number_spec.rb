# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe ReferenceNumber do
    let(:reference_number) { described_class.create }
    let(:increment) { reference_number.increment }
    let(:number) { reference_number.number }

    describe "#number" do
      it "is prefixed" do
        expect(number).to match(/^#{described_class::PREFIX}/)
      end

      it "contains increment" do
        expect(number).to match(increment)
      end

      it "is padded" do
        expect(number).to match(/#{described_class::PADDING}#{increment}/)
      end

      it "is at least minimum length" do
        expect(number.length).to be >= described_class::MINIMUM_LENGTH
      end
    end

    describe "#increment" do
      it "is the id plus the offset" do
        expected = reference_number.id + described_class::OFFSET
        expect(increment).to eq(expected.to_s)
      end
    end
  end
end
