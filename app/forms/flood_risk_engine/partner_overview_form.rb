# frozen_string_literal: true

module FloodRiskEngine
  class PartnerOverviewForm < ::FloodRiskEngine::BaseForm
    delegate :completed_partners, to: :transient_registration

    def submit(_params)
      # Assign the params for validation and pass them to the BaseForm method for updating
      attributes = {}

      super(attributes)
    end
  end
end
