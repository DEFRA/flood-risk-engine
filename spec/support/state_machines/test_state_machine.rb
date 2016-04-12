module FloodRiskEngine
  class TestStateMachine < StateMachine
    initial :step1

    events do
      event :next_step, if: -> { target.business_type == :foo },
        step1: :step2,
        step2: :step3

      event :next_step, if: -> { target.business_type == :bar },
        step1: :step3
    end
  end
end
