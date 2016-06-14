require "rails_helper"

module FloodRiskEngine
  RSpec.describe Partner, type: :model do
    it { is_expected.to belong_to(:contact) }
    it { is_expected.to belong_to(:organisation) }
  end
end
