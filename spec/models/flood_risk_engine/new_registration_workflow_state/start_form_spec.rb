# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject(:new_registration) { build(:new_registration, workflow_state: "start_form") }

    describe "#workflow_state" do
      context "with :exemption_form state transitions" do
        context "with on next" do
          it_behaves_like "has next transition", next_state: "exemption_form"
        end

        context "with on back" do
          it "is unable to transition when the 'back' event is issued" do
            expect { new_registration.back }.to raise_error(AASM::InvalidTransition)
          end
        end
      end
    end
  end
end
