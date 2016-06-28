# Unlike WEX, this registration is not yet Complete, we are only submitting the application for BO review
# The user can no longer edit it (because the status will be moved on)
#
module FloodRiskEngine
  class SubmitEnrollmentService
    attr_reader :enrollment
    delegate :enrollment_exemptions, to: :enrollment

    def initialize(enrollment)
      @enrollment = enrollment
    end

    def finalize!
      enrollment.submit
      set_enrollment_exemptions_to_pending
      SendEnrollmentSubmittedEmail.new(enrollment).call
    end

    private

    def set_enrollment_exemptions_to_pending
      enrollment_exemptions.each do |enrollment_exemption|
        enrollment_exemption.pending! if enrollment_exemption.building?
      end
    end

  end
end
