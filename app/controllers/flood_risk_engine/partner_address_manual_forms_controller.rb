# frozen_string_literal: true

module FloodRiskEngine
  class PartnerAddressManualFormsController < ::FloodRiskEngine::FormsController
    def new
      super(PartnerAddressManualForm, "partner_address_manual_form")
    end

    def create
      super(PartnerAddressManualForm, "partner_address_manual_form")
    end

    private

    def transient_registration_attributes
      params
        .fetch(:partner_address_manual_form, {})
        .permit(
          transient_address: %i[premises street_address locality city postcode]
        )
    end
  end
end
