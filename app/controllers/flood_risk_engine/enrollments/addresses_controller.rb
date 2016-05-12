require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  module Enrollments
    class AddressesController < ApplicationController

      def show
        form
        @enrollment = Enrollment.find(params[:enrollment_id])
        @address = Address.find(params[:id])
      end

      private

      def form
        @form ||= AddressForm.new(address, enrollment)
      end
      helper_method :form

      def enrollment
        @enrollment ||= Enrollment.find(params[:enrollment_id])
      end

      def address
        @address ||= Address.find(params[:id])
      end
    end
  end
end
