module FloodRiskEngine
  module Steps
    class ConfirmationForm < BaseForm

      def self.factory(enrollment)
        raise(
          FormObjectError,
          "You have reached this Page in Error - no contact email has been collected"
        ) unless enrollment.correspondence_contact

        new(enrollment)
      end

      def self.params_key
        :confirmation
      end

      # This is read only on this form
      property :email, virtual: true

      def email
        # If we need to display multiple emails e.g contact and email_someone_else then this works
        # emails = [enrollment.correspondence_contact.email_address]
        # emails.map(&:downcase).uniq.to_sentence

        # For now
        enrollment.correspondence_contact.email_address
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
