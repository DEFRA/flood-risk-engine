module FloodRiskEngine
  module Steps
    class UnknownForm < BaseForm
      def self.factory(enrollment)
        new(enrollment)
      end

      def self.params_key
        :unknown
      end

      # Probably over-kill, but making validate and save return false
      # to ensure POSTing to this form doesn't lead anywhere.
      def validate(_params)
        false
      end

      def save
        false
      end
    end
  end
end
