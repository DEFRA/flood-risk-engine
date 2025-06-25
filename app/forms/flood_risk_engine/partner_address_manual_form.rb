# frozen_string_literal: true

module FloodRiskEngine
  class PartnerAddressManualForm < BaseForm
    include CanClearAddressFinderError

    delegate :last_partner, to: :transient_registration
    delegate :transient_address, to: :last_partner
    delegate :premises, :street_address, :locality, :city, to: :transient_address, allow_nil: true

    attr_writer :form_postcode

    def postcode
      @form_postcode || transient_address&.postcode
    end

    validates :transient_address, "flood_risk_engine/manual_address": true

    after_initialize :setup_postcode

    def submit(params)
      partner_address_params = params.fetch(:transient_address, {})

      attributes = strip_whitespace(partner_address_params)
      last_partner.transient_address = setup_new_address(attributes)

      return last_partner.save! if valid?

      false
    end

    private

    def setup_postcode
      self.form_postcode = last_partner.temp_postcode

      # Prefill the existing address unless the postcode has changed from the existing address's postcode
      last_partner.transient_address = nil unless saved_address_still_valid?
    end

    def saved_address_still_valid?
      @form_postcode == transient_address&.postcode
    end

    def setup_new_address(attributes)
      TransientAddress.new(attributes)
    end
  end
end
