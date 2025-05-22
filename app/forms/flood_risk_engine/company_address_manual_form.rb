# frozen_string_literal: true

module FloodRiskEngine
  class CompanyAddressManualForm < BaseForm
    include CanClearAddressFinderError

    delegate :company_address, :business_type, to: :transient_registration
    delegate :premises, :street_address, :locality, :city, to: :company_address, allow_nil: true

    attr_writer :form_postcode

    def postcode
      @form_postcode || company_address&.postcode
    end

    validates :company_address, "flood_risk_engine/manual_address": true

    after_initialize :setup_postcode

    def submit(params)
      super(company_address_attributes: params[:company_address] || {})
    end

    private

    def setup_postcode
      self.form_postcode = transient_registration.temp_company_postcode

      # Prefill the existing address unless the postcode has changed from the existing address's postcode
      transient_registration.company_address = nil unless saved_address_still_valid?
    end

    def saved_address_still_valid?
      @form_postcode == company_address&.postcode
    end
  end
end
