# frozen_string_literal: true

module FloodRiskEngine
  class ContactPhoneForm < ::FloodRiskEngine::BaseForm
    delegate :contact_phone, to: :transient_registration

    validates :contact_phone, "defra_ruby/validators/phone_number": true
  end
end
