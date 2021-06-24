# frozen_string_literal: true

module FloodRiskEngine
  class PartnerNameFormsController < ::FloodRiskEngine::FormsController
    def new
      super(PartnerNameForm, "partner_name_form")
    end

    def create
      super(PartnerNameForm, "partner_name_form")
    end
  end
end
