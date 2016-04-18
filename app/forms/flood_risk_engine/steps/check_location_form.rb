# This simple null form over rides validate/save etc because there is no data to
# collect on this page
#
module FloodRiskEngine
  module Steps
    class CheckLocationForm < FloodRiskEngine::Steps::BaseForm

      def self.factory(enrollment)
        new(enrollment)
      end

      def errors
          []
      end

      def save
          true
      end

      def validate(params)
          true
      end
    end
  end
end
