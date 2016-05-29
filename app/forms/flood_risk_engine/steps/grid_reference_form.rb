require_relative "../../../validators/flood_risk_engine/grid_reference_validator"
module FloodRiskEngine
  module Steps
    class GridReferenceForm < BaseForm

      def self.factory(enrollment)
        enrollment.exemption_location ||= Location.new
        new(enrollment.exemption_location, enrollment)
      end

      def self.t(locale, args = {})
        I18n.t [locale_key, locale].join, args
      end

      def self.params_key
        :grid_reference
      end

      property :grid_reference

      validates(
        :grid_reference,
        presence: {
          message: t(".errors.grid_reference.blank")
        },
        # using FloodRiskEngine::GridReferenceValidator
        "flood_risk_engine/grid_reference" => {
          message: t(".errors.grid_reference.invalid"),
          allow_blank: true
        }
      )

      property :description
      validates(
        :description,
        length: {
          maximum: 500,
          message: t(".errors.description.too_long", max: 500)
        }
      )

      property :dredging_length
      validates(
        :dredging_length,
        presence: {
          message: t(".errors.dredging_length.blank"),
          if: :require_dredging_length?
        },
        length: {
          maximum: 25,
          message: t(".errors.dredging_length.too_long", max: 25),
          allow_blank: true,
          if: :require_dredging_length?
        }
      )

      def save
        super
        enrollment.exemption_location ||= model
        enrollment.save
      end

      def require_dredging_length?
        enrollment.exemptions.any?(&:long_dredging?)
      end
    end
  end
end
