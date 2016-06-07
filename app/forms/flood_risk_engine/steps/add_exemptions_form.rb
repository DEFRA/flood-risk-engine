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
          maximum: 1,
          message: :select_at_lease_one_exemptions
        }
      )

      def initialize(enrollment)
        super enrollment
        @all_exemptions = Exemption.all
      end

      def exemption_ids=(id)
        super [id]
      end

      def params_key
        :add_exemptions
      end
    end
  end
end
