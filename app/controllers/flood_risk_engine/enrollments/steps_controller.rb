# The idea here is that a separate step controller is responsible for
# the progressive 'building' of the enrollment. This has a couple of
# advantages over using custom get and patch routes to target
# enrollments_controller#edit and #update:
# - clearer separation of concerns
# - leaves EnrollmentsController free for more conventional use
# - steps maps to views in the way we wanted e.g. views/enrollments/steps
# - using a REST approach eg enrollments/123/steps/step1
#
# Ideally there should be only one variable passed to the view - @form -
# but if there are read-only items also required, I think creating a
# @presenter and passing it to the view would also be a good idea.
# Read-only data should not be shoe-horned into the form object as
# thats not its responsibility, and I'm not a fan of helpers.
# The presenter could be loaded in the same way
# as the form below but default to nil if no matching presenter class
# found (or its not defined in the presenter method case statement).
#
module FloodRiskEngine
  module Enrollments
    class StepsController < ApplicationController
      def edit
        render step, locals: locals
      end

      def update
        if form.validate(params) && form.save
          # here we want to redirect to the next step - how to get it?
          # time for a state machine..?
          redirect_to step_url
        else
          # see #locals for comment
          render step, locals: locals
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
        case step.to_sym
        when :step1 then :step2
        when :step2 then :step3
        else fail "End of the line"
        end
      end

      # Trying the approach that all vars are passed explicitly to the template
      # rather than relying on exposing @vars which, lets face it, is not great ;-)
      def locals
        {
          form: form,
          step: step
        }
      end

      # Delegate instantiation of the form object to a factory method
      # on the class itself, as there may be context-specific setup.
      def form
        @form ||= form_object_klass.factory(enrollment)
      end

      # I think dynamic resolution of the form object is going to be required
      # e.g. FloodRiskEngine.const_get("Steps::#{}Form".classify)
      def form_object_klass
        case step.to_sym
        when :step1 then FloodRiskEngine::Steps::Step1Form
        when :step2 then FloodRiskEngine::Steps::Step2Form
        when :step3 then FloodRiskEngine::Steps::Step3Form
        else fail "No form object defined for step #{step}"
        end
      end

      def enrollment
        @enrollment ||= Enrollment.find(params[:id])
      end
    end
  end
end
