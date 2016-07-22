require "rails_helper"

module FloodRiskEngine
  describe ReviewWorkFlow do
    let(:review_work_flow) { described_class.new(:local_authority) }
    let(:steps) { review_work_flow.work_flow }

    describe "::REVIEW_STEP" do
      it "should be :check_your_answers" do
        expect(described_class::REVIEW_STEP).to eq(:check_your_answers)
      end
    end

    describe "#make_hash" do
      let(:hash) { review_work_flow.make_hash(steps) }
      let(:review_step) { described_class::REVIEW_STEP }
      let(:review_step_array) { hash.rassoc(review_step).first }
      let(:postcode_step) { steps.select { |s| s.to_s =~ /_postcode$/ }.first }
      let(:address_step) { steps.select { |s| s.to_s =~ /_address$/ }.first }

      it "should have a value matching the review step" do
        expect(hash.values).to include(:check_your_answers)
      end

      it "should have an array key for the review step" do
        expect(review_step_array).to be_a(Array)
      end

      it "review step array should not have a postcode entry" do
        expect(review_step_array.any? { |s| s.to_s =~ /_postcode/ }).to eq(false)
      end

      it "should have a key value pair of postcode and address" do
        expect(hash[postcode_step]).to eq(address_step)
      end
    end
  end
end
