# frozen_string_literal: true

module FloodRiskEngine
  class PartnerAddressLookupFormsController < ::FloodRiskEngine::FormsController
    include CanSkipToManualAddress

    def new
      super(PartnerAddressLookupForm, "partner_address_lookup_form")
    end

    def create
      super(PartnerAddressLookupForm, "partner_address_lookup_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:partner_address_lookup_form, {}).permit(transient_address: [:uprn])
    end
  end
end
