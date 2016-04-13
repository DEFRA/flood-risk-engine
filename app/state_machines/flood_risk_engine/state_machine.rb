# State machines are using FiniteMachine
# https://github.com/piotrmurach/finite_machine
require "finite_machine"
module FloodRiskEngine
  class StateMachine < FiniteMachine::Definition
    callbacks do
      on_enter do |event|
        target.step_history << event.from if target.respond_to?(:step_history)
      end
    end
  end
end
