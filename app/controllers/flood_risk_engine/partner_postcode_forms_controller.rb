# frozen_string_literal: true

module FloodRiskEngine
  class PartnerPostcodeFormsController < ::FloodRiskEngine::FormsController
    include CanSkipToManualAddress

    def new
      super(PartnerPostcodeForm, "partner_postcode_form")
    end

    def create
      super(PartnerPostcodeForm, "partner_postcode_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:partner_postcode_form, {}).permit(:temp_postcode)
    end
  end
end
