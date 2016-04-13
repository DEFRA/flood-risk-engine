module FloodRiskEngine
  module Steps
    class ApplicantContactEmailForm < BaseForm

      property :email_address

      def self.factory(enrollment)
        contact = enrollment.applicant_contact || Contact.new
        new(contact, enrollment)
      end

      def params_key
        :applicant_contact_email
      end

      def save
        super
      end
    end
  end
end
