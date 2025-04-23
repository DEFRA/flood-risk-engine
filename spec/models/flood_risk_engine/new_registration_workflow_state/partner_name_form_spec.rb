# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject(:new_registration) { build(:new_registration, workflow_state: "partner_name_form") }

    describe "#workflow_state" do
      context "with :partner_name_form state transitions" do
        context "with on next" do
          it_behaves_like "has next transition", next_state: "partner_postcode_form"
        end

        context "with on back" do
          context "when the registration has existing partners" do
            before { allow(new_registration).to receive(:existing_partners?).and_return(true) }

            it_behaves_like "has back transition", previous_state: "partner_overview_form"
          end

          it_behaves_like "has back transition", previous_state: "business_type_form"
        end
      end
    end
  end
end
