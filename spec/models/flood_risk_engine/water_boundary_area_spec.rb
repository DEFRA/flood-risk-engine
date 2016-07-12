require "rails_helper"

module FloodRiskEngine
  RSpec.describe WaterBoundaryArea, type: :model do
    it { is_expected.to respond_to(:code) }
  end
end
