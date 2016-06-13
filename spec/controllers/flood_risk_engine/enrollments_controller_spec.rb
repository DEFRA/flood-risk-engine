require "rails_helper"
module FloodRiskEngine
  module Enrollments
    RSpec.describe EnrollmentsController, type: :controller do
      routes { Engine.routes }

      context "new action" do
        let(:initial_enrollment_count) { @initial_enrollment_count ||= Enrollment.count }
        let(:enrollment) { Enrollment.last }
        before do
          initial_enrollment_count
          get :new
        end

        it "should create a new enrollment" do
          expect(Enrollment.count).to eq(initial_enrollment_count + 1)
        end

        it "should redirect to the start of steps for new enrollment" do
          expect(response).to redirect_to(
            enrollment_step_path(enrollment, enrollment.initial_step)
          )
        end

        it "should set journey token in session" do
          expect(cookies.encrypted[:journey_token]).to eq(enrollment.token)
        end
      end
    end

  end
end
