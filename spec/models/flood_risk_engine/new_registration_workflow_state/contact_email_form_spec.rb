# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject { build(:new_registration, workflow_state: "contact_email_form") }

    describe "#workflow_state" do
      context "with :contact_email_form state transitions" do
        context "on next" do
          include_examples "has next transition", next_state: "additional_contact_email_form"
        end

        context "on back" do
          include_examples "has back transition", previous_state: "contact_phone_form"
        end
      end
    end
  end
end
