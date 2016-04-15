# This controller is responsible for the progressive 'building' of an
# enrollment. This has a couple of advantages over using custom get
# and patch routes to target enrollments_controller#edit and #update:
# - clearer separation of concerns
# - leaves EnrollmentsController free for more conventional use
# - 'steps' map to 'views' naturally e.g. app/views/enrollments/steps
# - more RESTful e.g. enrollments/123/steps/step1
#
module FloodRiskEngine
  module Enrollments
    class StepsController < ApplicationController
      def edit
        render :edit, locals: locals
      end

      def update
        enrollment.go_forward
        #check_step_is_valid
        if save_form!
          redirect_to step_url
        else
          render :edit, locals: locals
        end
      end

      private

      def step
        params.fetch(:step).to_sym
      end

      def step_url
        url_for([:build_step, enrollment, step: next_step])
      end

      def next_step
        enrollment.go_forward
        enrollment.current_step
      end

      def check_step_is_valid
        unless step.to_s == enrollment.current_step.to_s
          raise "!! #{step} != #{enrollment.current_step}"
        end
      end

      def save_form!
        form.validate(params) &&
          enrollment.set_step_as(step) &&
          enrollment.save && form.save
      end

      # Trying the approach that all vars are passed explicitly to the template
      # rather than relying on exposing @vars which, lets face it, is not great.
      def locals
        {
          form: form,
          step: step
        }
      end

      # Delegate instantiation of the form object to an abstract factory
      def form
        @form ||= Steps::FormObjectFactory.form_object_for(step, enrollment)
      end

      def enrollment
        @enrollment ||= Enrollment.find(params[:id])
      end
    end
  end
end
