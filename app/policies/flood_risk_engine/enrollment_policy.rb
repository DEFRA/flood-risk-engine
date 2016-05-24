# We don't have devise yet - so this is not a real Pundit policy for now

module FloodRiskEngine
  class EnrollmentPolicy

    def self.show_continue_button?(record)
      # All states except :confirmation
      !record.state_machine.state_machine.confirmation?
    end

  end
end
