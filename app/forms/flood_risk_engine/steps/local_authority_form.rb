module FloodRiskEngine
  module Steps
    class LocalAuthorityForm < FloodRiskEngine::Steps::BaseForm

      def self.factory(enrollment)
        organisation = enrollment.organisation || Organisation.new
        new(organisation, enrollment)
      end

      def self.params_key
        :local_authority
      end

      def self.name_max_length
        200
      end

      property :name

      validates :name, presence: { message: I18n.t("#{LocalAuthorityForm.locale_key}.errors.name.blank") }

      validates :name, 'flood_risk_engine/text_field_content': true, allow_blank: true

      validates :name, length: {
        maximum: LocalAuthorityForm.name_max_length,
        message: I18n.t("#{LocalAuthorityForm.locale_key}.errors.name.too_long")
      }


      def save
        super
        enrollment.organisation ||= model
        enrollment.save
      end
    end
  end
end
