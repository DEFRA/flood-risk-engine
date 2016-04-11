require_dependency "reform"

# Common step form functionality.
module FloodRiskEngine
  module Steps
    class BaseForm < Reform::Form
      # So we can always build an enrollment step url
      def enrollment_id
        @enrollment.id
      end

      def initialize(model, enrollment = nil)
        @enrollment = enrollment || model
        super(model)
      end
    end
  end
end
