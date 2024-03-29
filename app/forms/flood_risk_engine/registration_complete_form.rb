# frozen_string_literal: true

module FloodRiskEngine
  class RegistrationCompleteForm < ::FloodRiskEngine::BaseForm
    def self.can_navigate_flexibly?
      false
    end

    # Override BaseForm method as users shouldn't be able to submit this form
    def submit; end

    def email
      emails = [
        transient_registration.contact_email,
        transient_registration.additional_contact_email
      ]
      emails.compact_blank.map(&:downcase).uniq.to_sentence
    end
  end
end
