require "rails_helper"

module FloodRiskEngine
  RSpec.describe Enrollment, type: :model do
    let(:enrollment) { create(:enrollment) }
    let(:steps) { %w[step1 step2 step3] }

    describe "#rollback_to" do
      before do
        enrollment.next_step
        enrollment.next_step
        enrollment.save
      end

      context "return to midpoint" do
        let(:target_step) { 1 }
        before { enrollment.rollback_to steps[target_step] }

        it "should set current step to rolled back step" do
          expect(enrollment.current_step).to eq(steps[target_step])
        end

        it "should reset history back to match change" do
          expect(enrollment.step_history).to eq(steps[0, target_step].collect(&:to_sym))
        end
      end

      context "return to start" do
        let(:target_step) { 0 }
        before { enrollment.rollback_to steps[target_step] }

        it "should set current step to rolled back step" do
          expect(enrollment.current_step).to eq(steps[target_step])
        end

        it "should reset history back to match change" do
          expect(enrollment.step_history).to eq(steps[0, target_step].collect(&:to_sym))
        end
      end

      context "return to unknown" do
        it "should raise an error" do
          expect { enrollment.rollback_to("unknown") }.to raise_error Enrollment::StateMachineError
        end
      end
    end
  end
end
