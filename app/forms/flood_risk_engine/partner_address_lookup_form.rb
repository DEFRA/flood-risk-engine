# frozen_string_literal: true

module FloodRiskEngine
  class PartnerAddressLookupForm < BaseAddressLookupForm
    delegate :last_partner, to: :transient_registration
    delegate :temp_postcode, :transient_address, to: :last_partner

    alias existing_address transient_address
    alias postcode temp_postcode

    validates :transient_address, "flood_risk_engine/address": true

    def submit(params)
      partner_address_params = params.fetch(:transient_address, {})
      attributes = get_address_data(partner_address_params[:uprn], :operator)

      attributes = strip_whitespace(attributes)
      last_partner.transient_address = setup_new_address(attributes)

      return last_partner.save! if valid?

      false
    end

    private

    def setup_new_address(attributes)
      TransientAddress.new(attributes)
    end
  end
end
