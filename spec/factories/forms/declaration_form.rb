# frozen_string_literal: true

FactoryBot.define do
  factory :declaration_form, class: FloodRiskEngine::DeclarationForm do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            declaration: true,
            workflow_state: "declaration_form"
          )
        )
      end
    end
  end
end
