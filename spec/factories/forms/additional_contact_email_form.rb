# frozen_string_literal: true

FactoryBot.define do
  factory :additional_contact_email_form, class: "FloodRiskEngine::AdditionalContactEmailForm" do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            additional_contact_email: "also_valid@example.com",
            workflow_state: "additional_contact_email_form"
          )
        )
      end
    end
  end
end
