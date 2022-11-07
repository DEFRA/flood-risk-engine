# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    describe "#workflow_state" do
      it_behaves_like "a fixed final state",
                      current_state: :registration_complete_form,
                      factory: :new_registration
    end
  end
end
