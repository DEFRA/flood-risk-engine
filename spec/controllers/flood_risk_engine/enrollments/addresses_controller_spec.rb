require "rails_helper"

module FloodRiskEngine
  RSpec.describe Enrollments::AddressesController, type: :controller do
    routes { Engine.routes }
    render_views
    let(:enrollment) { FactoryGirl.create(:enrollment) }
  end
end
