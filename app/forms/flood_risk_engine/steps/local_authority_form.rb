module FloodRiskEngine
  module Steps
    class LocalAuthorityForm < FloodRiskEngine::Steps::BaseForm

      def self.factory(enrollment)
        organisation = enrollment.organisation || Organisation.new
        new(organisation, enrollment)
      end

      def self.locale_key
        "flood_risk_engine.enrollments.steps"
      end

      validates :name, presence: {
        message: I18n.t("#{LocalAuthorityForm.locale_key}.errors.name.blank")
      }

      validates :name, length: {
        maximum: 255, message: I18n.t("#{LocalAuthorityForm.locale_key}.errors.name.too_long")
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
