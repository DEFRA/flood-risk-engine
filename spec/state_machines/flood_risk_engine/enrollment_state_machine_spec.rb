require "rails_helper"

module FloodRiskEngine
  RSpec.describe Enrollment, type: :model do
    let(:enrollment_state_machine) do
      state_machine = EnrollmentStateMachine.new
      state_machine.target enrollment
      state_machine
    end

    context "enrollment is a foo" do
      let(:enrollment) { OpenStruct.new(business_type: :foo) }
      let(:steps) { [:step1, :step2, :step3] }

      it "should progess through foo journey" do
        expect(enrollment_state_machine.state).to eq(steps[0])
        enrollment_state_machine.next_step
        expect(enrollment_state_machine.state).to eq(steps[1])
        enrollment_state_machine.next_step
        expect(enrollment_state_machine.state).to eq(steps[2])
      end
    end

    context "enrollment is a bar" do
      let(:enrollment) { OpenStruct.new(business_type: :bar) }
      let(:steps) { [:step1, :step3] }

      it "should progess through foo journey" do
        expect(enrollment_state_machine.state).to eq(steps[0])
        enrollment_state_machine.next_step
        expect(enrollment_state_machine.state).to eq(steps[1])
      end
    end
  end
end
