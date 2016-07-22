module FloodRiskEngine
  # Modifies WorkFlow so that:
  #   ParnershipReviewWorkFlow.for(work_flow) should return a hash to build
  #   state machine rules once a work flow reaches the review step, when the
  #   organisation type is a partnership
  class PartnershipReviewWorkFlow < WorkFlow
    attr_accessor :steps

    DETAILS_STEP = :partnership_details

    # This should return a hash with elements building the rules:
    #   - The next step is the review step except for the partnership steps
    #   - The next step is the review step for the partnership_details step
    #   - The workflow for the other partnership steps should be as `WorkFlow`
    #
    # So something like:
    # {
    #   [:step_one, :step_two, :partnership_details] => REVIEW_STEP,
    #   :partnership => :partnership_postcode,
    #   :partnership_postcode => :partnership_address,
    #   :partnershup_address => :partnership_details
    # }
    def make_hash(steps)
      self.steps = steps
      {
        non_partnership_and_detail_steps => REVIEW_STEP
      }.merge normal_work_flow.make_hash(partnership_steps)
    end

    def non_partnership_and_detail_steps
      non_partnership_steps + [DETAILS_STEP]
    end

    def non_partnership_steps
      steps.reject { |step| step.to_s =~ partnership_pattern }
    end

    def partnership_steps
      steps.select { |step| step.to_s =~ partnership_pattern }
    end

    def partnership_pattern
      /^partnership/
    end

    def normal_work_flow
      @normal_work_flow ||= WorkFlow.new(:partnership)
    end
  end
end
