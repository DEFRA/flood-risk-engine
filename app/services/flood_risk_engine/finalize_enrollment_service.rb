# Note the term Finalize here may have become misleading.
# Unlike WEX, we are submitting the application for BO review - so it's final
# in the sense that the user can no longer edit it (because the status will be moved on)
# but that's all.
module FloodRiskEngine
  class FinalizeEnrollmentService
    attr_reader :enrollment

    def initialize(enrollment)
      @enrollment = enrollment
    end

    def finalize!
      validate_enrollment
      enrollment.pending!
      SendEnrollmentSubmittedEmail.new(enrollment).call
    end

    private

    def validate_enrollment
      raise(ArgumentError, "Enrollment missing") if enrollment.nil?
      unless enrollment.building?
        raise InvalidEnrollmentStateError,
              "Expected enrollment to have status 'building' but was '#{enrollment.status}'"
      end
    end
  end
end
