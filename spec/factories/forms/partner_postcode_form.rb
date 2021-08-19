# frozen_string_literal: true

FactoryBot.define do
  factory :partner_postcode_form, class: FloodRiskEngine::PartnerPostcodeForm do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            :has_named_partner,
            workflow_state: "partner_postcode_form"
          )
        )
      end
    end
  end
end
