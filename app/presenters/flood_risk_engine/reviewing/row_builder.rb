module FloodRiskEngine
  module Reviewing
    class RowBuilder
      include Engine.routes.url_helpers
      attr_reader :enrollment, :i18n_scope
      delegate :organisation_type, to: :enrollment_presenter

      def initialize(enrollment, i18n_scope)
        @enrollment = enrollment
        @i18n_scope = i18n_scope
      end

      def registration_date_row
        build_row name: :registration_date,
                  value: I18n.l(DateTime.zone.now, format: :short)
      end

      def organisation_type_row
        build_row name: :organisation_type,
                  value: organisation_type,
                  display_step_url: false
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

      def organisation_name_row
        build_row name: :organisation_name,
                  value: enrollment_presenter.organisation_name,
                  step: organisation_type
      end

      def organisation_address_row
        build_row name: :organisation_address,
                  value: enrollment_presenter.organisation_address,
                  step: "#{organisation_type}_address"
      end

      def applicant_contact_name_row
        build_row name: :applicant_contact_email,
                  value: "123213"
      end

      def applicant_contact_email_row
        build_row name: :applicant_contact_email,
                  value: "1212"
      end

      def applicant_contact_telephone_row
        build_row name: :applicant_contact_telephone,
                  value: "1212"
      end

      private

      def build_row(name:,
                    value:,
                    step: nil,
                    display_step_url: true,
                    **t_options)
        step ||= name
        Row.new(
          key: name,
          title: row_t(name, :title, t_options),
          value: value,
          step_url: (url_for_step(step.to_sym) if display_step_url)
        )
      end

      def url_for_step(step)
        enrollment_step_path(enrollment, step.to_sym)
      end

      def row_t(step, key, opts = {})
        I18n.t(".rows.#{step}.#{key}", opts.merge(scope: i18n_scope))
      end

      def enrollment_presenter
        @enrollment_presenter ||= EnrollmentPresenter.new(enrollment)
      end

    end
  end
end
