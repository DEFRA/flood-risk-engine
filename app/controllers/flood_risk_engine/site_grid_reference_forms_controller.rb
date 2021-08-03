# frozen_string_literal: true

module FloodRiskEngine
  class SiteGridReferenceFormsController < ::FloodRiskEngine::FormsController
    def new
      super(SiteGridReferenceForm, "site_grid_reference_form")
    end

    def create
      super(SiteGridReferenceForm, "site_grid_reference_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:site_grid_reference_form, {}).permit(:temp_grid_reference,
                                                         :temp_site_description,
                                                         :dredging_length)
    end
  end
end
