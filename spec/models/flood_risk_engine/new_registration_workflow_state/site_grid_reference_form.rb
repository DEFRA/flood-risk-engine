# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject { build(:new_registration, workflow_state: "site_grid_reference_form") }

    describe "#workflow_state" do
      context "with :site_grid_reference_form state transitions" do
        context "with on next" do
          it_behaves_like "has next transition", next_state: "business_type_form"
        end

        context "with on back" do
          it_behaves_like "has back transition", previous_state: "confirm_exemption_form"
        end
      end
    end
  end
end
