require "rails_helper"

module FloodRiskEngine
  describe PartnershipReviewWorkFlow do
    let(:work_flow) { described_class.new(:partnership) }
    let(:steps) { work_flow.work_flow }

    describe "::DETAILS_STEP" do
      it "should be :partnership_details" do
        expect(described_class::DETAILS_STEP).to eq(:partnership_details)
      end
    end

    describe "#make_hash" do
      let(:hash) { work_flow.make_hash(steps) }
      let(:review_step) { described_class::REVIEW_STEP }
      let(:details_step)  { described_class::DETAILS_STEP }
      let(:review_step_array) { hash.rassoc(review_step).first }

      context "the review step pair" do
        it "should have a value matching the review step" do
          expect(hash.values).to include(:check_your_answers)
        end

        it "should have an array key" do
          expect(review_step_array).to be_a(Array)
        end

        it "the array key should only have one partnership entry" do
          expect(review_step_array.select { |s| s.to_s =~ /^partnership_/ }.length).to eq(1)
        end

        it "the one partnership entry should be the details step" do
          expect(review_step_array).to include(details_step)
        end

        it "should have key value pairs for the partnership section" do
          expect(hash[:partnership]).to eq(:partnership_postcode)
          expect(hash[:partnership_postcode]).to eq(:partnership_address)
          expect(hash[:partnership_address]).to eq(details_step)
        end
      end
    end
  end
end
