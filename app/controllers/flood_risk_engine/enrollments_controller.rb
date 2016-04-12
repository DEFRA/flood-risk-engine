require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  class EnrollmentsController < ApplicationController
    def new
      enrollment = Enrollment.create
      # could put this in a helper
      url = url_for([:build_step, enrollment, step: "activity_location"])
      # or url = build_step_enrollment_path(id: enrollment.id, step: 'activity_location')
      redirect_to url
    end
  end
end
