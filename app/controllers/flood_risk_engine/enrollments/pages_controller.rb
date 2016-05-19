module FloodRiskEngine
  module Enrollments

    # N.B The show action is not over ridden so still uses the default high voltage location
    # for the html partials of views/pages

    class PagesController < ApplicationController

      include HighVoltage::StaticPage

      before_action :enrollment, only: [:show]

      private

      def enrollment
        @enrollment = Enrollment.find_by_token!(params[:enrollment_id])
      end

    end
  end
end
