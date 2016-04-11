require "rails_helper"

module FloodRiskEngine
  RSpec.describe Enrollment, type: :model do
    it { is_expected.to belong_to(:applicant_contact) }
  end
end
