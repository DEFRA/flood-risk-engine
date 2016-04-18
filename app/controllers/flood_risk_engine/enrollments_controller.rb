require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  class EnrollmentsController < ApplicationController
    def new
      enrollment = Enrollment.create
      # TODO: make first step come from state_machine
      url = stepped_enrollment_path(enrollment, step: enrollment.initial_step)
      redirect_to url
    end
  end
end
