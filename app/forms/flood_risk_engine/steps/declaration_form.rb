# Use this form object for steps with no html form
module FloodRiskEngine
  module Steps
    class DeclarationForm < BaseForm
      def save
        true
      end

      def validate(_params)
        true
      end
    end
  end
end
