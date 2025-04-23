# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject { build(:new_registration, workflow_state: "check_your_answers_form") }

    describe "#workflow_state" do
      context "with :check_your_answers_form state transitions" do
        context "on next" do
          it_behaves_like "has next transition", next_state: "declaration_form"
        end

        context "on back" do
          it_behaves_like "has back transition", previous_state: "additional_contact_email_form"
        end
      end
    end
  end
end
