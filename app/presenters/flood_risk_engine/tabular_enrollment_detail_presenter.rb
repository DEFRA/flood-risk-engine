#
# Aggregates and exposes tabular summarized enrollment data for use in a view, for example
# the 'check your answers' page or the confirmation email.
#
module FloodRiskEngine
  class TabularEnrollmentDetailPresenter

    # Options
    # * i18n_scope
    # * enrollment
    # * display_change_url
    # We currently just pass them through to the RowBuilder.
    def initialize(options = {})
      @options = options
    end

    def rows
      @rows ||= build_rows
    end

    private

    def build_rows
      [
        row_builder.exemptions_rows,
        row_builder.grid_reference_row,
        row_builder.organisation_type_row,
        row_builder.organisation_name_row,
        row_builder.organisation_address_row,
        row_builder.organisation_registration_number_row,
        row_builder.correspondence_contact_name_row,
        row_builder.correspondence_contact_telephone_row,
        row_builder.correspondence_contact_email_row
      ].flatten.compact
    end

    def row_builder
      @row_builder ||= TabularEnrollmentDetail::RowBuilder.new(@options)
    end
  end
end
