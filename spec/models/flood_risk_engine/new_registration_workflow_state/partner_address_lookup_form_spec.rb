# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    describe "#workflow_state" do
      it_behaves_like "an address lookup transition",
                      next_state_if_not_skipping_to_manual: :partner_overview_form,
                      address_type: "partner",
                      factory: :new_registration
    end
  end
end
