# Turning off Style/HashSyntax as `:step1 => :step2` describes the flow
# better than `step1: :step2`
# rubocop:disable Style/HashSyntax
module FloodRiskEngine
  class EnrollmentStateMachine < StateMachine
    initial :activity_location

    events do
      event :next_step,
        :activity_location => :step2,
        :step2 => :organisation_type
    end
  end
end
# rubocop:enable Style/HashSyntax
