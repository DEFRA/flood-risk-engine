# frozen_string_literal: true

module FloodRiskEngine
  class ContactNameForm < ::FloodRiskEngine::BaseForm
    delegate :contact_name, to: :transient_registration
    delegate :contact_position, to: :transient_registration

    validates :contact_name, "flood_risk_engine/contact_name": true
    validates :contact_position, "defra_ruby/validators/position": true
  end
end
