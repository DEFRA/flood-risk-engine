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

    # rubocop:disable Metrics/AbcSize
    def build_rows
      arr = []
      arr.push row_builder.registration_date_row
      arr.push(*row_builder.exemptions_rows)
      arr.push row_builder.grid_reference_row
      arr.push row_builder.organisation_type_row
      arr.push row_builder.organisation_name_row
      arr.push row_builder.organisation_address_row
      arr.push row_builder.correspondence_contact_name_row
      arr.push row_builder.correspondence_contact_telephone_row
      arr.push row_builder.correspondence_contact_email_row
      arr
    end

    def row_builder
      @row_builder ||= TabularEnrollmentDetail::RowBuilder.new(@options)
    end
  end
end
