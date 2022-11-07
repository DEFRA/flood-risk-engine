# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject(:new_registration) { build(:new_registration, workflow_state: "business_type_form") }

    describe "#workflow_state" do
      context "with :business_type_form state transitions" do
        context "on next" do
          context "when the registration should have partners" do
            before { allow(new_registration).to receive(:partnership?).and_return(true) }

            include_examples "has next transition", next_state: "partner_name_form"
          end

          context "when the registration should have a company number" do
            before { allow(new_registration).to receive(:company_no_required?).and_return(true) }

            include_examples "has next transition", next_state: "company_number_form"
          end

          include_examples "has next transition", next_state: "company_name_form"
        end

        context "on back" do
          include_examples "has back transition", previous_state: "site_grid_reference_form"
        end
      end
    end
  end
end
