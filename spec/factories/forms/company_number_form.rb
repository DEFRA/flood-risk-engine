# frozen_string_literal: true

FactoryBot.define do
  factory :company_number_form, class: FloodRiskEngine::CompanyNumberForm do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            company_number: "10997904",
            workflow_state: "company_number_form"
          )
        )
      end
    end
  end
end
