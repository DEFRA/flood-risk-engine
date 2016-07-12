require_relative "../../../validators/flood_risk_engine/grid_reference_validator"
module FloodRiskEngine
  module Steps
    class GridReferenceForm < BaseForm

      def self.factory(enrollment)
        enrollment.exemption_location ||= Location.new
        new(enrollment.exemption_location, enrollment)
      end

      def self.params_key
        :grid_reference
      end

      def self.config
        FloodRiskEngine.config
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
        presence: {
          message: t(".errors.description.blank")
        },
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
        numericality: {
          only_integer: true,
          greater_than_or_equal_to: config.minumum_dredging_length_in_metres,
          less_than_or_equal_to: config.maximum_dredging_length_in_metres,
          allow_blank: true,
          message:
            t(".errors.dredging_length.numeric",
              min: config.minumum_dredging_length_in_metres,
              max: config.maximum_dredging_length_in_metres),
          if: :require_dredging_length?
        }
      )

      def save
        super
        enrollment.exemption_location ||= model
        enrollment.save.tap do
          UpdateWaterBoundaryAreaJob.perform_later(enrollment.exemption_location)
        end
      end

      def require_dredging_length?
        enrollment.exemptions.any?(&:long_dredging?)
      end
    end
  end
end
