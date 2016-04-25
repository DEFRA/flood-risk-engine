module FloodRiskEngine
  module Steps
    class AddExemptionsForm < BaseForm
      property :exemption_ids

      attr_reader :all_exemptions

      def self.factory(enrollment)
        new(enrollment)
      end

      validates(
        :exemption_ids,
        length: {
          minimum: 1,
          message: "Select at least one exemption"
        }
      )

      def initialize(enrollment)
        super enrollment
        @all_exemptions = Exemption.all
      end

      def params_key
        :add_exemptions
      end
    end
  end
end
