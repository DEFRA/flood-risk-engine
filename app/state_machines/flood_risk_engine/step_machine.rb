module FloodRiskEngine
  class StepMachine
    attr_reader :target, :state_machine_class, :initiating_step
    def initialize(target:,
                    state_machine_class:,
                    step: nil)
      @target = target
      @state_machine_class = state_machine_class
      @initiating_step = step
    end

    def current_step
      state.to_s
    end

    def set_step_as(step)
      restore!(step)
    end

    def rollback_to(step)
      current = current_step
      while current_step != step do
        go_back! step
      end
    rescue FiniteMachine::InvalidStateError
      restore! current
      raise StateMachineError, "Unable to rollback to #{step}"
    end

    def previous_step?(step)
      around_step do
        go_back
        current_step == step.to_s
      end
    end

    def next_step?(step)
      around_step do
        go_forward
        current_step == step.to_s
      end
    end

    # Allows a process to be called that will temporarily change state
    # After around_step, the state will be return to the starting state.
    # `around_step` returns the result of the inner process.
    # Usage:
    #   current_state == :foo
    #   around_step do
    #     change_state_to_bar
    #     current_state == :bar
    #   end
    #   current_state == :foo
    #
    def around_step
      current = current_step
      result = yield
      restore! current
      result
    end

    def defined_steps
      states.collect(&:to_s)
    end

    def state_machine
      @state_machine ||= initiate_state_machine
    end
    delegate(
      :go_forward, :state, :restore!, :states, :go_back, :go_back!,
      to: :state_machine
    )

    private
    def initiate_state_machine
      state_machine = state_machine_class.new
      state_machine.target(target)
      state_machine.restore!(initiating_step.to_sym) if initiating_step.present?
      state_machine
    end
  end
end
