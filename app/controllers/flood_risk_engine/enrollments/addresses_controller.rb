require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  module Enrollments
    class AddressesController < ApplicationController

      def show
        form
        @enrollment = Enrollment.find(params[:enrollment_id])
        @address = Address.find(params[:id])
      end

      def update
        redirect_to target_url
      end

      private

      def form
        @form ||= AddressForm.new(address, enrollment)
      end
      helper_method :form

      def target_url
        if save_form!
          step_forward
          enrollment_step_path(enrollment, enrollment.current_step)
        else
          edit_enrollment_address_path(enrollment, address, check_for_error: true)
        end
      end

      def save_form!
        return false unless form.validate(params)
        return false unless enrollment.save
        form.save
      end

      def enrollment
        @enrollment ||= Enrollment.find_by_token!(params[:enrollment_id])
      end

      def address
        @address ||= Address.find(params[:id])
      end

      def step_forward
        enrollment.go_forward
        enrollment.save
      end
    end
  end
end
