require "rails_helper"

module FloodRiskEngine
  RSpec.describe Organisation, type: :model do
    it { is_expected.to belong_to(:contact) }
    it { is_expected.to have_one(:enrollment).dependent(:restrict_with_exception) }

    it { is_expected.to have_one(:primary_address).dependent(:restrict_with_exception) }
  end
end
