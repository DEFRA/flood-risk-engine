require "rails_helper"

module FloodRiskEngine
  describe StepMachine do
    let(:host) do
      OpenStruct.new(
        step: nil,
        business_type: :foo
      )
    end
    let(:step_machine) do
      StepMachine.new(
        host: host,
        state_machine_class: TestStateMachine
      )
    end
    let(:steps) { %w[step1 step2 step3] }
    let(:initial_step) { steps.first }

    describe ".next_step" do
      it "should change current step to next step" do
        expect(step_machine.current_step).to eq(steps[0])
        step_machine.next_step
        expect(step_machine.current_step).to eq(steps[1])
        step_machine.next_step
        expect(step_machine.current_step).to eq(steps[2])
      end
    end

    describe ".go_back" do
      before {step_machine.restore! steps.last.to_sym}
      it "should change current step to previous step" do
        expect(step_machine.current_step).to eq(steps[2])
        step_machine.go_back!
        expect(step_machine.current_step).to eq(steps[1])
        step_machine.go_back
        expect(step_machine.current_step).to eq(steps[0])
      end
    end

    describe ".set_step_as" do
      let(:new_step) { steps[2] }
      it "should change the current step to the new step" do
        step_machine.set_step_as new_step
        expect(step_machine.current_step).to eq(new_step)
      end
    end

    describe ".rollback_to" do
      before do
        step_machine.next_step
        step_machine.next_step
      end
      context "before test" do
        it "should be at final step" do
          expect(step_machine.current_step).to eq(steps.last)
        end
      end

      it "should change step to a previous step" do
        step_machine.rollback_to initial_step
        expect(step_machine.current_step).to eq(initial_step)
      end
    end

    describe ".previous_step?" do
      before do
        step_machine.next_step
      end

      it "should be true if match" do
        expect(step_machine.previous_step?(initial_step)).to be(true)
      end

      it "should be false if not a match" do
        expect(step_machine.previous_step?(steps.last)).to be(false)
      end
    end

    describe ".next_step?" do
      it "should return next step" do
        expect(step_machine.next_step?(steps[1])).to eq(true)
      end
    end
  end
end
