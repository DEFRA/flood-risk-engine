require "rails_helper"

module FloodRiskEngine
  RSpec.describe Enrollment, type: :model do
    before(:all) do
      Enrollment.state_machine_class = TestStateMachine
    end
    after(:all) do
      Enrollment.state_machine_class = nil
    end

    let(:enrollment) { create(:enrollment) }
    let(:steps) { TestStateMachine::WorkFlow.steps.collect!(&:to_s) }

    describe "#rollback_to" do
      before do
        enrollment.go_forward
        enrollment.go_forward
        enrollment.save
      end

      context "return to midpoint" do
        let(:target_step) { 1 }
        before { enrollment.rollback_to steps[target_step] }

        it "should set current step to rolled back step" do
          expect(enrollment.current_step).to eq(steps[target_step])
        end
      end

      context "return to start" do
        let(:target_step) { 0 }
        before { enrollment.rollback_to steps[target_step] }

        it "should set current step to rolled back step" do
          expect(enrollment.current_step).to eq(steps[target_step])
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
