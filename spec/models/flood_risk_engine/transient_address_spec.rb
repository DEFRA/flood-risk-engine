# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe TransientAddress, type: :model do
    subject(:transient_address) { create(:transient_address) }
  end
end
