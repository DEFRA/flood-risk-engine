# A set of class methods that allow a default state machine
# class to be set, but also alternatives to be selected
# at run time.
module FloodRiskEngine
  module Concerns
    module StateMachineSwitcher
      def state_machine_class=(state_machine_class)
        @state_machine_class = state_machine_class
      end

      def state_machine_class
        @state_machine_class ||= default_state_machine
      end

      def default_state_machine=(state_machine_class)
        @default_state_machine = state_machine_class
      end

      def default_state_machine
        @default_state_machine
      end
    end
  end
end
