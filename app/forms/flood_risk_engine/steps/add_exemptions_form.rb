module FloodRiskEngine
  module Steps

    class AddExemptionForm < FloodRiskEngine::Steps::BaseForm
      def self.factory(enrollment)
        new(enrollment)
      end

      def initialize(enrollment)
        super  enrollment
        @exemptions = Exemption.all
      end

      attr_reader :exemptions

      def params_key
        :add_exemptions_id
      end

      def save
        super
      end

      collection :exemptions do
        property :code
      end

    end
  end
end
