# frozen_string_literal: true

module FloodRiskEngine
  class PartnerPostcodeForm < BasePostcodeForm
    delegate :last_partner, to: :transient_registration
    delegate :temp_postcode, to: :last_partner

    validates :temp_postcode, "defra_ruby/validators/postcode": true
    validates :temp_postcode, "flood_risk_engine/address_lookup": true

    def submit(params)
      params[:temp_postcode] = format_postcode(params[:temp_postcode])

      # We persist the postcode regardless of validations.
      last_partner.update(temp_postcode: params[:temp_postcode])

      super({})
    end
  end
end
