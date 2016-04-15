module FloodRiskEngine
  module Steps
    class ReviewingForm < BaseForm
      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform

      def self.factory(enrollment)
        def initialize(enrollment)
          super enrollment
          @enrollment_review = DigitalServicesCore::EnrollmentReview.new(enrollment)
          @review_data_sections = @enrollment_review.prepare_review_data_list
        end

        new(enrollment)
      end

      attr_reader :enrollment_review, :review_data_sections

      def params_key
        :check_your_answers
      end

      def save
        super
      end
    end
  end
end
