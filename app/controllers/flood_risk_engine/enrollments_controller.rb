require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  class EnrollmentsController < ApplicationController
    def new
      enrollment = Enrollment.create
      # could put this in a helper
      url = url_for([:build_step, enrollment, step: "step1"])
      # or url = build_step_enrollment_path(id: enrollment.id, step: 'step1')
      redirect_to url
    end
  end
end
