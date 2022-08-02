# frozen_string_literal: true

module FloodRiskEngine
  class SiteGridReferenceForm < ::FloodRiskEngine::BaseForm
    delegate :temp_grid_reference, to: :transient_registration
    delegate :temp_site_description, to: :transient_registration
    delegate :dredging_length, to: :transient_registration

    validates :temp_grid_reference, "defra_ruby/validators/grid_reference": true
    validates :temp_site_description, "flood_risk_engine/site_description": true

    validates :dredging_length,
              presence: {
                message: I18n.t(".activemodel.errors.models" \
                                ".flood_risk_engine/site_grid_reference_form" \
                                ".attributes.dredging_length.blank"),
                if: :require_dredging_length?
              },
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: FloodRiskEngine.config.minimum_dredging_length_in_metres,
                less_than_or_equal_to: FloodRiskEngine.config.maximum_dredging_length_in_metres,
                allow_blank: true,
                message: I18n.t(".activemodel.errors.models" \
                                ".flood_risk_engine/site_grid_reference_form" \
                                ".attributes.dredging_length.numeric"),
                if: :require_dredging_length?
              }

    def require_dredging_length?
      transient_registration.exemptions.any?(&:long_dredging?)
    end
  end
end
