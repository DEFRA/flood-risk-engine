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

      # Note we don't need to call super in this form object to save the properties (type).
      # That's because our end goal is to create a new Organisation
      # object of the correct STI type, assinged to enrollment.organisation.
      # The form's :type property in this instance is only used to 'cast' the
      # organisation to the correct type; organisation.type is saved implicitly
      # when we save the enrollment
      def save

        begin
          enrollment.organisation = organisation_cast_to_the_chosen_sti_type
          Rails.logger.debug("Save Enrollment with Organisation set to [#{model.inspect}]")
          enrollment.save
        rescue => x
          Rails.logger.error(x.inspect)
          Rails.logger.error("Failed to save Enrollment with Organisation set to [#{model.inspect}]")
        end

      end

      private

      def organisation_cast_to_the_chosen_sti_type
        # TOFIX - type from params properly
        type ||= "OrganisationTypes::Individual"

        organisation_sti_class = FloodRiskEngine.const_get(type)
        Rails.logger.debug("Setting Org Type to [#{organisation_sti_class}]")

        # TODO : this beceoms call does not seem to set the type ?? ...  so added explicit call for now
        # model.becomes(organisation_sti_class)
        model.type = organisation_sti_class
        model
      end
    end
  end
end
