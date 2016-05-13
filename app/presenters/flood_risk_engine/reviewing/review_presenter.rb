#
# Aggregates and exposes tabular summarized enrollment data for use in a view, for example
# the 'check your answers' page or the confirmation email.
#
module FloodRiskEngine
  module Reviewing
    class ReviewPresenter
      attr_reader :options

      def initialize(enrollment, i18n_scope)
        @options = {
          i18n_scope: i18n_scope,
          enrollment: enrollment
        }
      end

      # Add to this function as required. Define new rowbuilders for each row
      # of review data, and make them do the the work.
      def rows
        arr = []
        arr << RowBuilders::OrganisationTypeRowBuilder.new(options).build
        arr << RowBuilders::GridReferenceRowBuilder.new(options).build
        enrollment.exemptions.each do |exemption|
          arr << RowBuilders::ExemptionRowBuilder.new(options).build(exemption)
        end
        # ...
        arr
      end

      private

      def enrollment
        options[:enrollment]
      end
    end
  end
end
