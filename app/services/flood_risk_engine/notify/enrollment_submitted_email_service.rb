# frozen_string_literal: true

module FloodRiskEngine
  module Notify
    class EnrollmentSubmittedEmailService < BaseSendEmailService
      private

      def notify_options
        {
          email_address: @recipient_address,
          template_id: template_id,
          personalisation: {
            registration_number: @enrollment.reference_number,
            exemption_description: enrollment_description
          }
        }
      end

      def template_id
        "6e444a8c-c656-45aa-97d8-e95181ff3a75"
      end
    end
  end
end
