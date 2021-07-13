# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe TransientRegistrationExemption, type: :model do
    subject(:transient_registration_exemption) { create(:transient_registration_exemption) }
  end
end
