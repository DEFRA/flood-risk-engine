# frozen_string_literal: true

FactoryBot.define do
  factory :exemption_form, class: "FloodRiskEngine::ExemptionForm" do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            workflow_state: "exemption_form"
          )
        )
      end
    end
  end
end
