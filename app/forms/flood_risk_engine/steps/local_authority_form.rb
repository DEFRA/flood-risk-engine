module FloodRiskEngine
  module Steps
    class LocalAuthorityForm < FloodRiskEngine::Steps::BaseForm

      def self.factory(enrollment)
        organisation = enrollment.organisation || Organisation.new
        new(organisation, enrollment)
      end

      def self.locale_key
        "flood_risk_engine.enrollments.steps.local_authority"
      end

      def self.name_max_length
        200
      end

      validation :name_present? do
        validates :name, presence: {
          message: I18n.t("#{LocalAuthorityForm.locale_key}.errors.name.blank")
        }
      end

      include ActiveModel::Validations
      validation :email_format, if: :name_present? do
        validates :name, 'flood_risk_engine/name_format': true
      end

      validates :name, length: {
        maximum: LocalAuthorityForm.name_max_length,
        message: I18n.t("#{LocalAuthorityForm.locale_key}.errors.name.too_long")
      }

      property :name

      def params_key
        :local_authority
      end

      def save
        super
        enrollment.organisation ||= model
        enrollment.save
      end
    end
  end
end
