require "rails_helper"

module FloodRiskEngine
  RSpec.describe WaterManagementArea, type: :model do
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:long_name) }
  end
end
