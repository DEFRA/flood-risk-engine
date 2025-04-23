# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject(:new_registration) { build(:new_registration, workflow_state: "partner_overview_form") }

    describe "#workflow_state" do
      context "with :partner_overview_form state transitions" do
        context "with on next" do
          it_behaves_like "has next transition", next_state: "contact_name_form"
        end

        context "with on back" do
          it_behaves_like "has back transition", previous_state: "business_type_form"
        end

        context "with on add_new_partner" do
          it "can transition to partner_name_form" do
            current_state = new_registration.workflow_state

            expect(new_registration).to transition_from(current_state).to(:partner_name_form).on_event(:add_new_partner)
          end
        end
      end
    end
  end
end
