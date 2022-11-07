# frozen_string_literal: true

FactoryBot.define do
  factory :business_type_form, class: "FloodRiskEngine::BusinessTypeForm" do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            business_type: "limitedCompany",
            workflow_state: "business_type_form"
          )
        )
      end
    end
  end
end
