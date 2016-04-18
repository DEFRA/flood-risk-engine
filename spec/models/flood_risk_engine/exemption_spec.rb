require "rails_helper"

module FloodRiskEngine
  RSpec.describe Exemption, type: :model do
    it { is_expected.to be_valid }
    it { is_expected.to have_many(:enrollment_exemptions).dependent(:restrict_with_exception) }
    it { is_expected.to have_many(:enrollments).through(:enrollment_exemptions) }
  end
end
