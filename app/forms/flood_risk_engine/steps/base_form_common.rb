# Common step form functionality that can be mixed into all Forms via BaseForm.
module FloodRiskEngine
  module Steps
    module BaseFormCommon

      extend self

      def locale_key
        "flood_risk_engine.enrollments.steps.#{self.params_key}"
      end

      def params_key
        self.class.params_key
      end

    end
  end
end
