# frozen_string_literal: true

module FloodRiskEngine
  class EnrollmentMailerPreview < ActionMailer::Preview
    def submitted
      EnrollmentMailer.submitted(enrollment_id: Enrollment.last,
                                 recipient_address: "test@example.com")
    end
  end
end
