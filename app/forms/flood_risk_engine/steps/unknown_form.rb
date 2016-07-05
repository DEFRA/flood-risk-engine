module FloodRiskEngine
  module Steps
    class UnknownForm < BaseForm
      def self.factory(enrollment)
        new(enrollment)
      end

      def self.params_key
        :unknown
      end

      def validate(_params)
        false
      end

      def save
        false
      end
    end
  end
end
