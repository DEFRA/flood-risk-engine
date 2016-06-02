module FloodRiskEngine
  module Steps
    class LimitedCompanyNumberForm < FloodRiskEngine::Steps::BaseForm

      def self.factory(enrollment)
        raise(FormObjectError, "No Organisation set for step #{enrollment.current_step}") unless enrollment.organisation

        new(enrollment.organisation, enrollment)
      end

      def self.params_key
        :limited_company_number
      end

      property :registration_number

      validates :registration_number, presence: {
        message:  I18n.t("#{LimitedCompanyNumberForm.locale_key}.errors.blank")
      }

      validates :registration_number, 'ea/validators/companies_house_number': { allow_blank: true }

    end
  end
end
