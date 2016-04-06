require "rails_helper"

module FloodRiskEngine
  RSpec.describe Organisation, type: :model do
    it { is_expected.to belong_to(:contact) }
  end
end
