# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject { build(:new_registration, workflow_state: "company_address_manual_form") }

    describe "#workflow_state" do
      context "with :company_address_manual_form state transitions" do
        context "when n next" do
          include_examples "has next transition", next_state: "contact_name_form"
        end

        context "on back" do
          include_examples "has back transition", previous_state: "company_postcode_form"
        end
      end
    end
  end
end
