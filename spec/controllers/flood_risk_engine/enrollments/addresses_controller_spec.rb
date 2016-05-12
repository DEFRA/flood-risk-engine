require "rails_helper"

module FloodRiskEngine
  module Enrollments
    RSpec.describe AddressesController, type: :controller do
      routes { Engine.routes }
      render_views
      let(:enrollment) { FactoryGirl.create(:enrollment) }
      let(:address) { FactoryGirl.create(:address) }

      describe "show action" do
        before do
          get :show, id: address, enrollment_id: enrollment
        end

        it "should render page sucessfully" do
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
