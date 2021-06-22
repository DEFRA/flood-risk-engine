# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration, type: :model do
    describe "#workflow_state" do
      it_behaves_like "a postcode transition",
                      previous_state: :company_name_form,
                      address_type: "company",
                      factory: :new_registration
    end
  end
end
