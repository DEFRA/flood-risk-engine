require "rails_helper"

module FloodRiskEngine
  module Enrollments
    RSpec.describe AddressesController, type: :controller do
      routes { Engine.routes }
      render_views
      let(:steps) { WorkFlow::Definitions.start }
      let(:step) { steps[1] }
      let(:next_step) { steps[2] }
      let(:enrollment) { FactoryGirl.create(:enrollment, step: step) }
      let(:address) { FactoryGirl.create(:address) }

      describe "show action" do
        before do
          get :show, id: address, enrollment_id: enrollment
        end

        it "should render page sucessfully" do
          expect(response).to have_http_status(:success)
        end
      end

      describe "update action" do
        before do
          expect_any_instance_of(AddressForm).to(
            receive(:validate).and_return(validation_result)
          )
          put(
            :update,
            id: address,
            enrollment_id: enrollment,
            flood_risk_engine_address: address.attributes
          )
        end

        context "on success" do
          let(:validation_result) { true }

          it "should redirect to the enrollment's next step on success" do
            expect(response).to redirect_to(
              enrollment_step_path(enrollment, next_step)
            )
          end
        end

        context "failure" do
          let(:validation_result) { false }

          it "should redirect back to show with check for errors" do
            expect(response).to redirect_to(
              enrollment_address_path(enrollment, address, check_for_error: true)
            )
          end
        end
      end
    end
  end
end
