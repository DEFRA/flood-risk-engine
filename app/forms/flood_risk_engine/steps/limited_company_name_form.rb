module FloodRiskEngine
  module Steps
    class LimitedCompanyNameForm < FloodRiskEngine::Steps::BaseForm

      def self.factory(enrollment)
        raise(FormObjectError, "No Organisation set for step #{enrollment.current_step}") unless enrollment.organisation
        new(enrollment.organisation, enrollment)
      end

      def self.params_key
        :limited_company_name
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
      # property :company_name

      # validates :company_name, presence: {
      #    message:  I18n.t("#{LimitedCompanyNameForm.locale_key}.company_name.errors.blank")
      # }

    end
  end
end
