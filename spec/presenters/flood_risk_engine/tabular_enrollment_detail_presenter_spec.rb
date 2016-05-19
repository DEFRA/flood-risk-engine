require "rails_helper"

module FloodRiskEngine
  RSpec.describe TabularEnrollmentDetailPresenter, type: :presenter do
    let(:enrollment) { build_stubbed(:enrollment) } # , token: "123") }
    subject { described_class.new(enrollment) }
  end
end
