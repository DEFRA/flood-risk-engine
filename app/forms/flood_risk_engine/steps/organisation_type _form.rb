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
        enrollment.organisation = organisation_cast_to_the_chosen_sti_type
        enrollment.save
      end

      # Readonly array of array of organisation types which can be used in radio button
      # groups. Example output:
      # [
      #   [
      #     FloodRiskEngine::OrganisationTypes::Individual,
      #     'Individual'
      #   ],
      #   [...]
      # ]
      #
      def organisation_types
        Organisation::TYPES.map do |organsation_sti_class|
          i18n_key = organsation_sti_class.name.demodulize.underscore
          [
            organsation_sti_class.to_s,
            I18n.translate(i18n_key, scope: "organisation_types")
          ]
        end
      end

      private

      def organisation_cast_to_the_chosen_sti_type
        organisation_sti_class = FloodRiskEngine.const_get(type)
        model.becomes(organisation_sti_class)
      end
    end
  end
end
