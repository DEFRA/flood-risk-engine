# frozen_string_literal: true

module Helpers
  module WorkflowStates
    def self.permitted_states(transient_registration)
      transient_registration.aasm.states(permitted: true).map(&:name)
    end
  end
end
