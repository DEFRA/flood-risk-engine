require "rails_helper"

module FloodRiskEngine
  RSpec.describe Contact, type: :model do
    it { is_expected.to respond_to(:telephone_number) }
    it { is_expected.to have_one(:organisation).dependent(:restrict_with_exception) }
    it { is_expected.to have_one(:address).dependent(:restrict_with_exception) }
    it { is_expected.to define_enum_for(:title) }
    it { is_expected.to define_enum_for(:contact_type) }
  end
end
