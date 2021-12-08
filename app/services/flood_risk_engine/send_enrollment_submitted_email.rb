module FloodRiskEngine

  class SendEnrollmentSubmittedEmail

    def initialize(enrollment)
      @enrollment = enrollment
    end

    def call
      validate_enrollment
      distinct_recipients.each do |recipient|

        Notify::EnrollmentSubmittedEmailService.run(
          enrollment: enrollment,
          recipient_address: recipient
        )
      end
    end

    private

    attr_reader :enrollment

    def validate_enrollment
      raise MissingEmailAddressError, "Missing contact email address" if primary_contact_email.blank?
    end

    def distinct_recipients
      [primary_contact_email, secondary_contact_email]
        .select(&:present?)
        .map(&:strip)
        .map(&:downcase)
        .uniq
    end

    def primary_contact_email
      enrollment.correspondence_contact.try :email_address
    end

    def secondary_contact_email
      enrollment.secondary_contact.try :email_address
    end
  end
end
