# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe WaterManagementArea do
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:long_name) }
  end
end
