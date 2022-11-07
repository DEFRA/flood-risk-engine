# frozen_string_literal: true

FactoryBot.define do
  factory :contact_email_form, class: "FloodRiskEngine::ContactEmailForm" do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            contact_email: "valid@example.com",
            workflow_state: "contact_email_form"
          )
        )
      end
    end
  end
end
