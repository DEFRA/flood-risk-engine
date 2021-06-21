# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration, type: :model do
    describe "#workflow_state" do
      current_state = :start_form
      subject(:new_registration) { create(:new_registration, workflow_state: current_state) }

      context "when a NewRegistration's state is #{current_state}" do
        it "can only transition to :exemption_form" do
          permitted_states = Helpers::WorkflowStates.permitted_states(new_registration)
          expect(permitted_states).to eq([:exemption_form])
        end

        it "changes to :exemption_form after the 'next' event" do
          expect(new_registration).to transition_from(current_state).to(:exemption_form).on_event(:next)
        end

        it "is unable to transition when the 'back' event is issued" do
          expect { new_registration.back }.to raise_error(AASM::InvalidTransition)
        end
      end
    end
  end
end
