# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject(:new_registration) { build(:new_registration, workflow_state: "company_name_form") }

    describe "#workflow_state" do
      context "with :company_name_form state transitions" do
        context "on next" do
          it_behaves_like "has next transition", next_state: "company_postcode_form"
        end

        context "on back" do
          context "when the registration should have a company number" do
            before { allow(new_registration).to receive(:company_no_required?).and_return(true) }

            it_behaves_like "has back transition", previous_state: "company_number_form"
          end

          it_behaves_like "has back transition", previous_state: "business_type_form"
        end
      end
    end
  end
end
