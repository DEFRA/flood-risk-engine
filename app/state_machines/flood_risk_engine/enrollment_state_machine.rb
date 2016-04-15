# Turning off Style/HashSyntax as `:step1 => :step2` describes the flow
# better than `step1: :step2`
# rubocop:disable Style/HashSyntax
module FloodRiskEngine
  class EnrollmentStateMachine < StateMachine
    initial :grid_reference

    events do
      event :next_step,
        :grid_reference => :applicant_contact_name,
        :applicant_contact_name => :organisation_type
    end
  end
end
# rubocop:enable Style/HashSyntax
