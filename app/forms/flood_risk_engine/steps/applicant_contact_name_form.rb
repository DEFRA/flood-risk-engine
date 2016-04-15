module FloodRiskEngine
  module Steps
    class ApplicantContactNameForm < BaseForm
      property :first_name # at some point make full_name

      validates :first_name, presence: true

      def self.factory(enrollment)
        contact = enrollment.applicant_contact || Contact.new
        new(contact, enrollment)
      end

      def params_key
        :applicant_contact_name
      end

      # Overriding #save here so we can wire up the enrollment.applicant_contact
      # Could use a transation here?
      def save
        super
        enrollment.applicant_contact = model
        enrollment.save
      end
    end
  end
end
