require "rails_helper"

module FloodRiskEngine
  RSpec.describe Enrollment, type: :model do
    let!(:work_flow) { FloodRiskEngine::WorkFlow::Definitions.local_authority }
    let!(:review_step) { :check_your_answers }
    let!(:step_before_review) do
      review_step_position = work_flow.index review_step
      work_flow[review_step_position - 1]
    end
    let(:enrollment) do
      FactoryGirl.create(
        :enrollment,
        :with_local_authority,
        step: step_before_review
      )
    end

    describe "#in_review?" do
      it "should return false initially" do
        expect(enrollment.in_review?).to be(false)
      end

      context "after entering review step" do
        before do
          enrollment.go_forward
        end

        it "should return true" do
          expect(enrollment.in_review?).to be(true)
        end
      end
    end
  end
end
