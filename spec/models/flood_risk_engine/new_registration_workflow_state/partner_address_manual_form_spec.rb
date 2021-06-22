# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject { build(:new_registration, workflow_state: "partner_address_manual_form") }

    describe "#workflow_state" do
      context ":partner_address_manual_form state transitions" do
        context "on next" do
          include_examples "has next transition", next_state: "partner_overview_form"
        end

        context "on back" do
          include_examples "has back transition", previous_state: "partner_postcode_form"
        end
      end
    end
  end
end
