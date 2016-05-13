require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  module Enrollments
    class AddressesController < ApplicationController

      def edit
        form.validate(session[:error_params]) if params[:check_for_error]
      end

      def update
        clear_error_params
        redirect_to target_url
      end

      private

      def form
        @form ||= AddressForm.new(enrollment, address)
      end
      helper_method :form

      def target_url
        if save_form!
          step_forward
          enrollment_step_path(enrollment, enrollment.current_step)
        else
          session[:error_params] = {
            address: params[:address]
          }
          edit_enrollment_address_path(enrollment, address, check_for_error: true)
        end
      end

      def save_form!
        return false unless form.validate(params)
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

      def clear_error_params
        session[:error_params] = {}
      end
    end
  end
end
