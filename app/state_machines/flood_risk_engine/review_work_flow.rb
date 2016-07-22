module FloodRiskEngine
  # Modifies WorkFlow so that:
  #   ReviewWorkFlow.for(work_flow) should return a hash to build
  #   state machine rules once a work flow reaches the review step
  class ReviewWorkFlow < WorkFlow

    # This should return a hash with elements building the rules:
    #   - The next step is the review step expect for the postcode steps
    #   - Postcode steps can step forward to the next step
    #
    # So something like:
    # {
    #   [:step_one, :step_two, :step_address] => REVIEW_STEP,
    #   step_postcode => :step_address
    # }
    #
    def make_hash(steps)
      {
        without_postcode(steps) => REVIEW_STEP
      }.merge(postcode_to_address_hash)
    end

    private

    def without_postcode(steps)
      steps.reject { |step| step.to_s =~ postcode_pattern }
    end

    def postcode_to_address_hash
      Hash[*postcode_and_following_step.flatten]
    end

    def postcode_and_following_step
      postcode_step_positions.collect { |i| work_flow[i, 2] }
    end

    def postcode_step_positions
      work_flow.select { |step| step.to_s =~ postcode_pattern }
               .collect { |step| work_flow.index(step) }
    end

    def postcode_pattern
      /_postcode$/
    end

  end
end
