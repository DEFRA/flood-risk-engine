# Unlike WEX, this registration is not yet Complete, we are only submitting the application for BO review
# The user can no longer edit it (because the status will be moved on)
#
module FloodRiskEngine
  class SubmitEnrollmentService
    attr_reader :enrollment

    def initialize(enrollment)
      @enrollment = enrollment
    end

    def finalize!
      validate_enrollment
      enrollment.submit
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