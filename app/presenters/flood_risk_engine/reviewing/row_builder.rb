module FloodRiskEngine
  module Reviewing
    class RowBuilder
      include Engine.routes.url_helpers
      attr_reader :enrollment, :i18n_scope

      def initialize(enrollment, i18n_scope)
        @enrollment = enrollment
        @i18n_scope = i18n_scope
      end

      def organisation_type_row
        Row.new(
          key: :organisation_type,
          title: row_t(:organisation_type, :title),
          value: enrollment_presenter.organisation_type
        )
      end

      def grid_reference_row
        Row.new(
          key: :grid_reference,
          title: row_t(:grid_reference, :title),
          value: enrollment_presenter.grid_reference,
          step_url: enrollment_step_path(enrollment, :grid_reference)
        )
      end

      def exemptions_rows
        enrollment.exemptions.map do |exemption|
          exemption_row(exemption)
        end
      end

      def exemption_row(exemption)
        Row.new(
          key: :exemption,
          title: row_t(:exemption, :title, code: exemption.code),
          value: exemption.summary,
          step_url: enrollment_step_path(enrollment, :check_exemptions)
        )
      end

      private

      def row_t(step, key, opts = {})
        I18n.t(".rows.#{step}.#{key}", opts.merge(scope: i18n_scope))
      end

      def enrollment_presenter
        @enrollment_presenter ||= EnrollmentPresenter.new(enrollment)
      end
    end
  end
end
