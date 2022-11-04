# frozen_string_literal: true

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
      journey_tokens << enrollment.token
      cookies.encrypted[:journey_token] = {
        value: journey_tokens.join(","),
        expires: journey_token_lifespan.from_now,
        httponly: true
      }
    end

    def enrollment
      @enrollment ||= Enrollment.create
    end

    def journey_token_lifespan
      ENV.fetch("JOURNEY_TOKEN_LIFE_IN_HOURS", 24).to_f.hours
    end

  end
end
