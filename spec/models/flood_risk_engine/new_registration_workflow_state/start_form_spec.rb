# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject { build(:new_registration, workflow_state: "start_form") }

    describe "#workflow_state" do
      context ":exemption_form state transitions" do
        context "on next" do
          include_examples "has next transition", next_state: "exemption_form"
        end

        context "on back" do
          it "is unable to transition when the 'back' event is issued" do
            expect { subject.back }.to raise_error(AASM::InvalidTransition)
          end
        end
      end
    end
  end
end
