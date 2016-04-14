module FloodRiskEngine
  module Steps
    class IndividualNameForm < BaseForm

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :full_name

      def self.factory(enrollment)
        contact = enrollment.applicant_contact || ::Contact.new
        new(contact, enrollment)
      end

      def params_key
        :individual_name
      end

      def save
        super
      end
    end
  end
end
