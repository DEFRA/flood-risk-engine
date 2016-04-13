require "rails_helper"

module FloodRiskEngine
  describe StepMachine do
    let(:host) do
      OpenStruct.new(
        step: nil,
        step_history: [],
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

    describe ".next_step?" do
      it "should return next step" do
        expect(step_machine.next_step?(steps[1])).to eq(true)
      end
    end
  end
end
