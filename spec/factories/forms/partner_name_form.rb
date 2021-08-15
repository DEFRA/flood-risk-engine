# frozen_string_literal: true

FactoryBot.define do
  factory :partner_name_form, class: FloodRiskEngine::PartnerNameForm do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            workflow_state: "partner_name_form"
          )
        )
      end
    end
  end
end
