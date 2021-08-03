# frozen_string_literal: true

module FloodRiskEngine
  class BusinessTypeForm < ::FloodRiskEngine::BaseForm
    delegate :business_type, to: :transient_registration

    validates :business_type, "defra_ruby/validators/business_type": true

    def business_types
      formatted_types = {}

      FloodRiskEngine::TransientRegistration::BUSINESS_TYPES.each do |key, value|
        formatted_types[value] = I18n.t("flood_risk_engine.business_type_forms.new.options.#{key}")
      end

      formatted_types
    end
  end
end
