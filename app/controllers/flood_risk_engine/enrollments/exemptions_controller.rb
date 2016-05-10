require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  module Enrollments
    class ExemptionsController < ApplicationController

      def show
        destroy # allows exemptions to be removed when JavaScript is disabled.
      end

      def destroy
        enrollment.exemptions.destroy(exemption)
        step_back if enrollment.exemptions.empty?
        redirect_to enrollment_step_path(enrollment, enrollment.current_step)
      end

      private

      def enrollment
        @enrollment ||= Enrollment.find(params[:enrollment_id])
      end

      def exemption
        @exemption ||= Exemption.find(params[:id])
      end

      def step_back
        enrollment.go_back
        enrollment.save
      end

    end
  end
end
