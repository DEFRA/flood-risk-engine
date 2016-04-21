# Use this form object for steps with no html form
module FloodRiskEngine
  module Steps
    class NullForm < BaseForm
      class DummyForm
        attr_reader :enrollment
        def initialize(enrollment)
          @enrollment = enrollment
        end

        def errors
          []
        end

        def save
          true
        end

        def validate(*)
          true
        end

        delegate :id, to: enrollment, prefix: true
      end

      def self.factory(enrollment)
        DummyForm.new(enrollment)
      end
    end
  end
end
