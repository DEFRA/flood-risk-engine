# frozen_string_literal: true

FactoryBot.define do
  factory :partner_address_manual_form, class: "FloodRiskEngine::PartnerAddressManualForm" do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            :has_named_partner_with_postcode,
            workflow_state: "partner_address_manual_form"
          )
        )
      end
    end
  end
end
