module FloodRiskEngine
  module Steps
    class Step2Form < BaseForm
      property :first_name

      validates :first_name, presence: true

      def self.factory(enrollment)
        contact = enrollment.applicant_contact || Contact.new
        new(contact, enrollment)
      end

      def params_key
        :step2
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
