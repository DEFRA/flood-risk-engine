module FloodRiskEngine
  module Steps
    class ApplicantContactForm < BaseForm

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform

      def self.factory(enrollment)
        contact = enrollment.applicant_contact || Contact.new
        new(contact, enrollment)
      end

      def params_key
        :applicant_contact
      end

      def save
        super
      end
    end
  end
end
