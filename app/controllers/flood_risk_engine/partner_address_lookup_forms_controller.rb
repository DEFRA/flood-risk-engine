# frozen_string_literal: true

module FloodRiskEngine
  class PartnerAddressLookupFormsController < ::FloodRiskEngine::FormsController
    def new
      super(PartnerAddressLookupForm, "partner_address_lookup_form")
    end

    def create
      super(PartnerAddressLookupForm, "partner_address_lookup_form")
    end
  end
end
