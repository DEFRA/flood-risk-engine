module FloodRiskEngine
  module Steps
    class ApplicantContactTelephoneForm < BaseForm

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :phone_number

      def self.factory(enrollment)
        contact = enrollment.correspondence_contact || ::Contact.new
        contact.phone_number = PhoneNumber.new
        new(contact, enrollment)
      end

      def params_key
        :applicant_contact_telephone
      end

      def save
        super
      end
    end
  end
end
