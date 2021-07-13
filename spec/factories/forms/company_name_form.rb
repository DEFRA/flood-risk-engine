# frozen_string_literal: true

FactoryBot.define do
  factory :company_name_form, class: FloodRiskEngine::CompanyNameForm do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            company_name: "Test Inc",
            workflow_state: "company_name_form"
          )
        )
      end
    end
  end
end
