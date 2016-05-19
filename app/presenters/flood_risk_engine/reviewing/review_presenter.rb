#
# Aggregates and exposes tabular summarized enrollment data for use in a view, for example
# the 'check your answers' page or the confirmation email.
#
module FloodRiskEngine
  module Reviewing
    class ReviewPresenter
      attr_reader :i18n_scope

      def initialize(enrollment, i18n_scope)
        @i18n_scope = i18n_scope
        @enrollment = enrollment
      end

      def rows
        @rows ||= build_rows
      end

      private

      attr_reader :enrollment

      # rubocop:disable Metrics/AbcSize
      def build_rows
        arr = []
        arr.push row_builder.registration_date_row
        arr.push(*row_builder.exemptions_rows)
        arr.push row_builder.grid_reference_row
        arr.push row_builder.organisation_type_row
        arr.push row_builder.organisation_name_row
        arr.push row_builder.organisation_address_row
        arr.push row_builder.applicant_contact_name_row
        arr.push row_builder.applicant_contact_telephone_row
        arr.push row_builder.applicant_contact_email_row
        arr
      end

      def row_builder
        @row_builder ||= RowBuilder.new(enrollment, i18n_scope, true)
      end
    end
  end
end
