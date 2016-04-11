module FloodRiskEngine
  module Steps
    class OrganisationTypeForm < BaseForm
      property :type
      validates :type, presence: true

      def self.factory(enrollment)
        organisation = enrollment.organisation || Organisation.new
        new(organisation, enrollment)
      end

      def params_key
        :organisation_type
      end

       # Overriding #save here so we can wire up the enrollment.applicant_contact
      # Could use a transation here?
      def save
        super
        enrollment.organisation = model
        enrollment.save
      end
    end
  end
end
