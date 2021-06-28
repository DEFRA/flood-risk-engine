# frozen_string_literal: true

module FloodRiskEngine
  class PartnerAddressManualFormsController < ::FloodRiskEngine::FormsController
    def new
      super(PartnerAddressManualForm, "partner_address_manual_form")
    end

    def create
      super(PartnerAddressManualForm, "partner_address_manual_form")
    end
  end
end
