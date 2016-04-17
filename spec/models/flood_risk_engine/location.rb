require "rails_helper"

module FloodRiskEngine
  RSpec.describe Location, type: :model do
    it { is_expected.to belong_to(:address) }
  end
end
