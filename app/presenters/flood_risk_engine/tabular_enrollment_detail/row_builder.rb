# rubocop:disable ClassLength
module FloodRiskEngine
  module TabularEnrollmentDetail
    class RowBuilder
      include Engine.routes.url_helpers
      attr_reader :enrollment, :i18n_scope, :display_change_url, :enrollment_presenter
      delegate :organisation_type, to: :enrollment_presenter

      # enrollment:         the enrollment
      # i18n_scope:         a locale key under which we expect to find row titles etc
      # display_change_url: true for the check your details page, false for confirmation email
      def initialize(enrollment:,
                     enrollment_presenter:,
                     i18n_scope:,
                     display_change_url:)
        @enrollment = enrollment
        @i18n_scope = i18n_scope
        @display_change_url = display_change_url
        @enrollment_presenter = enrollment_presenter
      end

      def organisation_type_row
        build_row name: :organisation_type,
                  value: organisation_type,
                  display_change_url: false
      end

      def grid_reference_row
        build_row name: :grid_reference,
                  value: enrollment_presenter.grid_reference
      end

      def exemptions_rows
        enrollment.exemptions.map do |exemption|
          exemption_row(exemption)
        end
      end

      def exemption_row(exemption)
        build_row name: :exemption,
                  value: exemption.summary,
                  step: :add_exemptions,
                  code: exemption.code
      end

      def location_description_row
        return unless enrollment_presenter.exemption_location
        build_row name: :location_description,
                  value: enrollment_presenter.exemption_location.description,
                  step: :grid_reference
      end

      def location_dredging_length_row
        return unless enrollment.enrollment_exemptions.include_long_dredging?
        dredging_length = enrollment_presenter.exemption_location.dredging_length
        formatted_dredging_length = ActiveSupport::NumberHelper.number_to_human(dredging_length, units: :distance)
        build_row name: :dredging_length,
                  value: formatted_dredging_length,
                  step: :grid_reference
      end

      def organisation_name_row
        build_row name: :organisation_name,
                  value: enrollment_presenter.organisation_name,
                  step: name_step(enrollment.org_type)
      end

      def organisation_address_row
        build_row name: :organisation_address,
                  value: enrollment_presenter.organisation_address,
                  step: "#{enrollment.org_type}_postcode"
      end

      def correspondence_contact_name_row
        build_row name: :correspondence_contact_name,
                  value: enrollment_presenter.correspondence_contact_name
      end

      def correspondence_contact_email_row
        build_row name: :correspondence_contact_email,
                  value: enrollment_presenter.correspondence_contact_email_address
      end

      def correspondence_contact_telephone_row
        build_row name: :correspondence_contact_telephone,
                  value: enrollment_presenter.correspondence_contact_telephone_number
      end

      def organisation_registration_number_row
        return unless enrollment_presenter.organisation_registration_number
        build_row name: :organisation_registration_number,
                  value:  enrollment_presenter.organisation_registration_number,
                  step: "#{enrollment.org_type}_number"
      end

      def partner_rows
        enrollment.partners.collect do |partner|
          partner_presenter = PartnerPresenter.new(partner)
          build_row name: :responsible_partner,
                    value: partner_presenter.to_single_line,
                    step: :partnership_details
        end
      end

      private

      # ==== Arguments
      # * +name+ -used as:
      #   * a data-xxx attribute in the markup for the row (to aid testing)
      #   * the locale key under which e.g. the row :title is found
      #   * the step name if none supplied
      # * +value+   - the value
      # * +step+    - the step name if different form the :name
      # * +display_change_url+ - hide the url if false - for example if this row's value
      #            cannot be changed. Defaults to the instance default (see initializer)
      # * +t_options+ - a hash passed to t() calls e.g. for variable interpolation
      def build_row(name:,
                    value:,
                    step: nil,
                    display_change_url: @display_change_url,
                    **t_options)
        step ||= name
        Row.new(
          name: name,
          title: row_t(name, :title, t_options),
          value: value,
          change_url: (url_for_step(step) if display_change_url),
          change_link_suffix: row_t(name,
                                    :accessible_change_link_suffix,
                                    t_options.merge(default: ""))
        )
      end

      def url_for_step(step)
        enrollment_step_path(enrollment, step.to_sym)
      end

      def row_t(step, key, opts = {})
        I18n.t!(".rows.#{step}.#{key}", opts.merge(scope: i18n_scope))
      end

      # There is an inconsistency to whether the step where a name is applied
      # has a name postscript. This method is a patch to handle this problem.
      def name_step(step)
        return unless step
        {
          local_authority:               :local_authority,
          limited_company:               :limited_company_name,
          limited_liability_partnership: :limited_liability_partnership_name,
          individual:                    :individual_name,
          partnership:                   :partnership,
          other:                         :other
        }[step.to_sym]
      end
    end
  end
end
