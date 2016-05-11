require "rails_helper"

module FloodRiskEngine
  RSpec.describe Address, type: :model do
    it { is_expected.to belong_to(:addressable) }
    it { is_expected.to have_one(:location) }
  end
end
