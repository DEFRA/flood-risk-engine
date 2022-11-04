# frozen_string_literal: true

FactoryBot.define do
  factory :company_postcode_form, class: "FloodRiskEngine::CompanyPostcodeForm" do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            temp_company_postcode: "BS1 5AH",
            workflow_state: "company_postcode_form"
          )
        )
      end
    end
  end
end
