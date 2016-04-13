# Turning off Style/HashSyntax as `:step1 => :step2` describes the flow
# better than `step1: :step2`
# rubocop:disable Style/HashSyntax
module FloodRiskEngine
  class EnrollmentStateMachine < StateMachine
    initial :grid_reference

    module WorkFlow
      extend self

      def start
        {
          :activity_location => :step2,
          :step2 => :organisation_type
        }
      end
    end

    events do
      event :next_step, WorkFlow.start
    end
  end
end
# rubocop:enable Style/HashSyntax
