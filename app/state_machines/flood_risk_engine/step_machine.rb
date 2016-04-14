module FloodRiskEngine
  class StepMachine
    attr_reader :host, :state_machine_class, :step_method
    def initialize  host:,
                    state_machine_class:,
                    step_method: :step
      @host = host
      @state_machine_class = state_machine_class
      @step_method = step_method
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
        next_step
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
      :next_step, :state, :restore!, :states, :go_back, :go_back!,
      to: :state_machine
    )

    private
    def initiate_state_machine
      state_machine = state_machine_class.new
      state_machine.target(host)
      state_machine.restore!(host_step) if host_step?
      state_machine
    end

    def host_step
      host.send step_method
    end

    def host_step?
      host_step.present?
    end
  end
end
