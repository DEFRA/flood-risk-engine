# frozen_string_literal: true

module FloodRiskEngine
  class AdditionalContactEmailForm < ::FloodRiskEngine::BaseForm
    delegate :additional_contact_email, to: :transient_registration
    attr_accessor :confirmed_email

    validates :additional_contact_email, "defra_ruby/validators/email": true
    validates :confirmed_email, "defra_ruby/validators/email": {
      messages: custom_error_messages(:confirmed_email, :blank, :invalid_format)
    }
    validates :confirmed_email, "flood_risk_engine/matching_email": { compare_to: :additional_contact_email }

    after_initialize :populate_confirmed_email

    def submit(params)
      # Assign the params for validation and pass them to the BaseForm method for updating
      self.confirmed_email = params[:confirmed_email]

      super(params.permit(:additional_contact_email))
    end

    private

    def populate_confirmed_email
      self.confirmed_email = additional_contact_email
    end
  end
end
