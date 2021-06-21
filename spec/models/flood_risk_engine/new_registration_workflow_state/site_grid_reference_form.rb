# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration, type: :model do
    describe "#workflow_state" do
      it_behaves_like "a simple bidirectional transition",
                      previous_state: :confirm_exemption_form,
                      current_state: :site_grid_reference_form,
                      next_state: :business_type_form,
                      factory: :new_registration
    end
  end
end
