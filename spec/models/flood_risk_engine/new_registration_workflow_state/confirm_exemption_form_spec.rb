# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject { build(:new_registration, workflow_state: "confirm_exemption_form") }

    describe "#workflow_state" do
      context "with :confirm_exemption_form state transitions" do
        context "on next" do
          include_examples "has next transition", next_state: "site_grid_reference_form"
        end

        context "on back" do
          include_examples "has back transition", previous_state: "exemption_form"
        end
      end
    end
  end
end
