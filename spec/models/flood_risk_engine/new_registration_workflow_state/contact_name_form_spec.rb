# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject { build(:new_registration, workflow_state: "contact_name_form") }

    describe "#workflow_state" do
      context ":contact_name_form state transitions" do
        context "on next" do
          include_examples "has next transition", next_state: "contact_phone_form"
        end

        context "on back" do
          context "when the registration is a partnership" do
            before { allow(subject).to receive(:should_have_partners?).and_return(true) }

            include_examples "has back transition", previous_state: "partner_overview_form"
          end

          context "when the registration's company address was entered manually" do
            let(:company_address) { double(:company_address, manual?: true) }

            before { allow(subject).to receive(:company_address).and_return(company_address) }

            include_examples "has back transition", previous_state: "company_address_manual_form"
          end

          include_examples "has back transition", previous_state: "company_address_lookup_form"
        end
      end
    end
  end
end
