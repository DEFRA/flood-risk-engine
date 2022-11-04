# frozen_string_literal: true

FactoryBot.define do
  factory :company_address_manual_form, class: "FloodRiskEngine::CompanyAddressManualForm" do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            temp_company_postcode: "BS1 5AH",
            workflow_state: "company_address_manual_form"
          )
        )
      end
    end
  end
end
