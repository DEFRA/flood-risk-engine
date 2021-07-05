module FloodRiskEngine
  module Steps
    class LimitedCompanyNameForm < FloodRiskEngine::Steps::BaseStepsForm

      def self.factory(enrollment)
        super enrollment, factory_type: :organisation
      end

      def self.params_key
        :limited_company_name
      end

      def self.config
        FloodRiskEngine.config
      end

      def self.max_length
        config.maximum_company_name_length || EA::Validators::CompaniesHouseNameValidator.name_max_length
      end

      property :name

      validates :name, presence: { message: I18n.t("#{LimitedCompanyNameForm.locale_key}.errors.name.blank") }

      validates :name, 'ea/validators/companies_house_name': true, allow_blank: true

      validates :name, length: {
        maximum: LimitedCompanyNameForm.max_length,
        message: I18n.t("#{LimitedCompanyNameForm.locale_key}.errors.name.too_long",
                        max_length: LimitedCompanyNameForm.max_length)
      }

    end
  end
end
