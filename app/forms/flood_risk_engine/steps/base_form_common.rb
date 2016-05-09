# Common step form functionality that can be mixed into all Forms via BaseForm.
module FloodRiskEngine
  module Steps
    module BaseFormCommon

      # rubocop:disable Style/ModuleFunction:
      # This one - Use module_function instead of extend self. - seems wrong as they are not exactly equivalent
      extend self

      def locale_key
        "flood_risk_engine.enrollments.steps.#{params_key}"
      end

      def params_key
        self.class.params_key
      end

      def validation_message_when(error_key)
        I18n.t("#{locale_key}.errors.#{error_key}")
      end

    end
  end
end
