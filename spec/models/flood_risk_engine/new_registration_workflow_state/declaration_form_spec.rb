# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject { build(:new_registration, workflow_state: "declaration_form") }

    describe "#workflow_state" do
      context "with :declaration_form state transitions" do
        context "on next" do
          it_behaves_like "has next transition", next_state: "registration_complete_form"
        end

        context "on back" do
          it_behaves_like "has back transition", previous_state: "check_your_answers_form"
        end
      end
    end
  end
end
