# frozen_string_literal: true

module FloodRiskEngine
  class PartnerPostcodeFormsController < ::FloodRiskEngine::FormsController
    def new
      super(PartnerPostcodeForm, "partner_postcode_form")
    end

    def create
      super(PartnerPostcodeForm, "partner_postcode_form")
    end
  end
end
