# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject { build(:new_registration, workflow_state: "partner_overview_form") }

    describe "#workflow_state" do
      context ":partner_overview_form state transitions" do
        context "on next" do
          include_examples "has next transition", next_state: "contact_name_form"
        end

        context "on back" do
          include_examples "has back transition", previous_state: "business_type_form"
        end

        context "on add_new_partner" do
          it "can transition to partner_name_form" do
            current_state = subject.workflow_state

            expect(subject).to transition_from(current_state).to(:partner_name_form).on_event(:add_new_partner)
          end
        end
      end
    end
  end
end
