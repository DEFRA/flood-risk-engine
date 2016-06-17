module FloodRiskEngine
  module Steps
    class PartnershipDetailForm < BaseForm
      def self.factory(enrollment)
        new(enrollment)
      end

      def save
        true
      end

      def validate(_params)
        true
      end
    end
  end
end
