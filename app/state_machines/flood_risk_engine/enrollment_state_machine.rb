# Turning off Style/HashSyntax as `:step1 => :step2` describes the flow
# better than `step1: :step2`
# rubocop:disable Style/HashSyntax
module FloodRiskEngine
  class EnrollmentStateMachine < StateMachine
    initial :Step1

    events do
      event :next_step, if: -> { target.business_type == :foo },
        :Step1 => :Step2,
        :Step2 => :Step3

      event :next_step, if: -> { target.business_type == :bar },
        :Step1 => :Step3
    end
  end
end
# rubocop:enable Style/HashSyntax
