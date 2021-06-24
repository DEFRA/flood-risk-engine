# frozen_string_literal: true

module FloodRiskEngine
  class SiteGridReferenceFormsController < ::FloodRiskEngine::FormsController
    def new
      super(SiteGridReferenceForm, "site_grid_reference_form")
    end

    def create
      super(SiteGridReferenceForm, "site_grid_reference_form")
    end
  end
end
