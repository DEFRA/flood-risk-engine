# frozen_string_literal: true

module FloodRiskEngine
  class BusinessTypeForm < ::FloodRiskEngine::BaseForm
    delegate :business_type, to: :transient_registration

    validates :business_type, "defra_ruby/validators/business_type": true
  end
end
