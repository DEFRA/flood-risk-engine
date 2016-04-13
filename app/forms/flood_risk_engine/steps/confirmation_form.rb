module FloodRiskEngine
  module Steps
    class ConfirmationForm < BaseForm

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform

      def self.factory(enrollment)
        new(enrollment)
      end

      def params_key
        :confirmation
      end

      def save
        super
      end
    end
  end
end
