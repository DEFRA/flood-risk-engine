require "rails_helper"

module FloodRiskEngine
  RSpec.describe Address, type: :model do
    let(:address) { build(:address) }
    it { is_expected.to belong_to(:contact) }
  end
end
