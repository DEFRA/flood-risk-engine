require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  class EnrollmentsController < ApplicationController
    def new
      store_journey_token_in_current_session
      redirect_to enrollment_step_path(enrollment, enrollment.initial_step)
    end

    private

    # journey token: used to identify if journey started in current browser session
    def store_journey_token_in_current_session
      cookies[:journey_token] = {
        value: encrypted_enrollment_token,
        expires: 24.hours.from_now
      }
    end

    def encrypted_enrollment_token
      encode enrollment.token
    end

    def enrollment
      @enrollment ||= Enrollment.create
    end
  end
end
