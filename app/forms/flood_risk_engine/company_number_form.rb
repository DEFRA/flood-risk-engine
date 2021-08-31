# frozen_string_literal: true

module FloodRiskEngine
  class CompanyNumberForm < ::FloodRiskEngine::BaseForm
    delegate :company_number, to: :transient_registration

    validates :company_number, "flood_risk_engine/company_number": true

    def submit(params)
      # Assign the params for validation and pass them to the BaseForm method for updating
      # If param isn't set, use a blank string instead to avoid errors with the validator
      params[:company_number] = process_company_number(params[:company_number])

      super
    end

    def business_type
      FloodRiskEngine::TransientRegistration::BUSINESS_TYPES.key(transient_registration.business_type)
    end

    private

    def process_company_number(company_number)
      return unless company_number.present?

      number = company_number.to_s
      # Should be 8 characters, so if it's not, add 0s to the start
      number = "0#{number}" while number.length < 8
      number
    end
  end
end
