require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  class EnrollmentsController < ApplicationController

    def new
      @enrollment = Enrollment.new

      @form = form_object
    end

    def create
      @enrollment = Enrollment.new

      @form = form_object

      if(@form.validate(params))
        # This is essentially the start of the journey, send new Enrollment in init state
        # to the Step Controller to take over
        if(enrollment_params["location_check"] == "yes")

          @enrollment = Enrollment.create
          @enrollment.go_forward
          @enrollment.save

          redirect_to  enrollment_step_path(@enrollment, @enrollment.step)
        else
          # This effectively ends the journey
          redirect_to main_app.page_path('contact_ea_location')
        end
      else
        # Perhaps should happen in Reform Form validation - we must have an answer
        render :new
      end

    end

    private

    # The form object factory dont work for new Enrollment sso have to roll our own
    def form_object
      "FloodRiskEngine::Steps::#{@enrollment.current_step.classify}Form".constantize.factory(@enrollment)
    end

    def enrollment_params
      params.require(:check_location).permit(:location_check)
    end

  end
end
