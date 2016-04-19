require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  class EnrollmentsController < ApplicationController

    def new
      @enrollment = Enrollment.new
    end

    def create

      # "enrollment"=>{"location_check"=>"yes"}
      if(enrollment_params["location_check"])

        # This is essentially the start of the journey, create new Enrollment in init state
        # and send to the Step Controller to take over
        if(enrollment_params["location_check"] == "yes")
          @enrollment = Enrollment.new

          respond_to do |format|
            if @enrollment.save
              format.html do
                redirect_to  enrollment_step_path(@enrollment, @enrollment.initial_step)
              end
            else
              format.html { render :new }
            end
          end
        else
          redirect_to main_app.page_path('contact_ea_location')
        end

      else
        # Perhaps should happen in Reform Form validation - we must have an answer
        redirect_to :new && return
      end

    end

    private
    def enrollment_params
      params.require(:enrollment).permit(:location_check)
    end

  end
end
