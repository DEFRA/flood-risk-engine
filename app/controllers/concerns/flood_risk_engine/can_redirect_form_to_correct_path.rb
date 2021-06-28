# frozen_string_literal: true

module FloodRiskEngine
  module CanRedirectFormToCorrectPath
    extend ActiveSupport::Concern

    included do
      def redirect_to_correct_form
        redirect_to form_path
      end

      # Get the path based on the workflow state, with token as params, ie:
      # new_state_name_path/:token or start_state_name_path?token=:token
      def form_path
        send("new_#{@transient_registration.workflow_state}_path".to_sym, token: @transient_registration.token)
      end
    end
  end
end
