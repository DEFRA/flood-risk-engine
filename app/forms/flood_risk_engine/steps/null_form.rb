# Use this form object for steps with no html form
module FloodRiskEngine
  module Steps
    class NullForm < BaseForm
      def self.factory(enrollment)
        new(enrollment)
      end

        delegate :id, to: :enrollment, prefix: true

      def validate(_params)
        true
      end
    end
  end
end
