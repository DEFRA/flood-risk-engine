module FloodRiskEngine
  module Steps
    class UserTypeForm < BaseForm
      property :org_type
      validates :org_type, presence: true

      def self.factory(enrollment)
        organisation = enrollment.organisation || Organisation.new
        new(organisation, enrollment)
      end

      def params_key
        :user_type
      end

      # Note we don't need to call super in this form object to save the properties (type).
      # That's because our end goal is to create a new Organisation
      # object of the correct STI type, assinged to enrollment.organisation.
      # The form's :type property in this instance is only used to 'cast' the
      # organisation to the correct type; organisation.type is saved implicitly
      # when we save the enrollment
      def save
        model.org_type = org_type.to_sym
        enrollment.organisation = model
        enrollment.save
      end

      def organisation_types
        Organisation.org_types.keys.collect do |org_type|
          [
            org_type,
            Organisation.human_attribute_name(org_type)
          ]
        end
      end
    end
  end
end
