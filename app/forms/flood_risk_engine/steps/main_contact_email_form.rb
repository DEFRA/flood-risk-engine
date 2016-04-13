module FloodRiskEngine
  module Steps
    class MainContactEmailForm < BaseForm

      # For full API see  - https://github.com/apotonick/reform
      property :email_address

      def self.factory(enrollment)
        contact = enrollment.correspondence_contact || Contact.new
        new(contact, enrollment)
      end

      def params_key
        :main_contact_email
      end

      def save
        super
      end
    end
  end
end
