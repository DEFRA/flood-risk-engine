module FloodRiskEngine
  module Steps
    class ConfirmationForm < BaseForm

      def self.params_key
        :confirmation
      end

      # This is read only on this form
      property :email, virtual: true

      def email
        emails = [
          enrollment.correspondence_contact.email_address,
          enrollment.secondary_contact.try(:email_address)
        ]
        emails.delete_if(&:blank?).map(&:downcase).uniq.to_sentence
      end

      def no_header_in_show
        true
      end

      private

      def initialize(enrollment)
        logger.info("#{enrollment.inspect} #{enrollment.correspondence_contact.inspect}")

        super enrollment
      end

    end
  end
end
