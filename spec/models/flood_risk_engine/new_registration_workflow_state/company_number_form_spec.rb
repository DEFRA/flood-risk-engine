# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject { build(:new_registration, workflow_state: "company_number_form") }

    describe "#workflow_state" do
      context ":company_number_form state transitions" do
        context "on next" do
          include_examples "has next transition", next_state: "company_name_form"
        end

        context "on back" do
          include_examples "has back transition", previous_state: "business_type_form"
        end
      end
    end
  end
end
