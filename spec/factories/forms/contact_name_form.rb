# frozen_string_literal: true

FactoryBot.define do
  factory :contact_name_form, class: "FloodRiskEngine::ContactNameForm" do
    trait :has_required_data do
      initialize_with do
        new(
          create(
            :new_registration,
            contact_name: "Test Person",
            workflow_state: "contact_name_form"
          )
        )
      end
    end
  end
end
