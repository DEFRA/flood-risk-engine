# frozen_string_literal: true

module FloodRiskEngine
  class PartnerOverviewFormsController < ::FloodRiskEngine::FormsController
    def new
      super(PartnerOverviewForm, "partner_overview_form")
    end

    def create
      super(PartnerOverviewForm, "partner_overview_form")
    end
  end
end
