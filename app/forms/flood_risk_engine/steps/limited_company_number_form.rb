module FloodRiskEngine
  module Steps
    class LimitedCompanyNumberForm < FloodRiskEngine::Steps::BaseStepsForm

      def self.factory(enrollment)
        super enrollment, factory_type: :organisation
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
