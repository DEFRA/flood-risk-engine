# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject(:new_registration) { build(:new_registration, workflow_state: "contact_name_form") }

    describe "#workflow_state" do
      context "with :contact_name_form state transitions" do
        context "on next" do
          it_behaves_like "has next transition", next_state: "contact_phone_form"
        end

        context "on back" do
          context "when the registration is a partnership" do
            before { allow(new_registration).to receive(:should_have_partners?).and_return(true) }

            it_behaves_like "has back transition", previous_state: "partner_overview_form"
          end

          context "when the registration's company address was entered manually" do
            let(:company_address) { double(:company_address, manual?: true) }

            before { allow(new_registration).to receive(:company_address).and_return(company_address) }

            it_behaves_like "has back transition", previous_state: "company_address_manual_form"
          end

          it_behaves_like "has back transition", previous_state: "company_address_lookup_form"
        end
      end
    end
  end
end
