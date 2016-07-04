#
# Aggregates and exposes tabular summarized enrollment data for use in a view, for example
# the 'check your answers' page or the confirmation email.
#
module FloodRiskEngine
  class TabularEnrollmentDetailPresenter
    delegate :reference_number, to: :enrollment

    # Options
    # * i18n_scope
    # * enrollment
    # * display_change_url
    # We currently just pass them through to the RowBuilder.
    def initialize(options = {})
      @enrollment = options.fetch(:enrollment)
      @options = options
      @options[:enrollment_presenter] = EnrollmentPresenter.new(@enrollment)
    end

    def rows
      @rows ||= build_rows
    end

    private

    attr_reader :enrollment

    def build_rows
      [
        row_builder.exemptions_rows,
        row_builder.grid_reference_row,
        row_builder.location_description_row,
        row_builder.location_dredging_length_row,
        row_builder.organisation_type_row,
        organisation_rows,
        row_builder.correspondence_contact_name_row,
        row_builder.correspondence_contact_telephone_row,
        row_builder.correspondence_contact_email_row
      ].flatten.compact
    end

    def row_builder
      @row_builder ||= TabularEnrollmentDetail::RowBuilder.new(@options)
    end

    def organisation_rows
      if enrollment.org_type == "partnership"
        row_builder.partner_rows
      else
        [
          row_builder.organisation_registration_number_row,
          row_builder.organisation_name_row,
          row_builder.organisation_address_row
        ]
      end
    end

  end
end
