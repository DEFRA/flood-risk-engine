require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  module Enrollments
    class PartnersController < ApplicationController

      # Used to handle delete link behaviour when JavaScript disabled.
      def show
        partner
      end

      def edit
        move_enrollment_to_partnership_start
        redirect_to enrollment_step_path(enrollment, enrollment.current_step)
      end

      def destroy
        partner.destroy
        move_enrollment_to_partnership_start if enrollment.reload.partners.empty?
        redirect_to enrollment_step_path(enrollment, enrollment.current_step)
      end

      private

      def enrollment
        @enrollment ||= Enrollment.find_by(token: params[:enrollment_id])
      end

      def partner
        @partner ||= enrollment.partners.find(params[:id])
      end

      def move_enrollment_to_partnership_start
        enrollment.set_step_as(:partnership)
        enrollment.save
      end

    end
  end
end
