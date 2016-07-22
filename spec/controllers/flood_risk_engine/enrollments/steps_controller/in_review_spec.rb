require "rails_helper"
module FloodRiskEngine
  module Enrollments
    describe StepsController, type: :controller do
      routes { Engine.routes }
      render_views

      describe "when in review and going to another step from review step" do
        let(:review_step) { WorkFlow::REVIEW_STEP }
        let(:target_step) { WorkFlow::Definitions.start.first }
        let(:enrollment) do
          FactoryGirl.create(
            :enrollment, :with_local_authority,
            step: review_step,
            in_review: true
          )
        end

        before do
          set_journey_token
          get :show, id: target_step, enrollment_id: enrollment
        end

        it "should render the page" do
          expect(response).to have_http_status(:success)
        end

        it "should reset the current step to the target step" do
          expect(enrollment.reload.step).to eq(target_step.to_s)
        end
      end
    end
  end
end
