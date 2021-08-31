# frozen_string_literal: true

module FloodRiskEngine
  module CanSkipToManualAddress
    extend ActiveSupport::Concern

    included do
      def skip_to_manual_address
        find_or_initialize_transient_registration(params[:token])

        @transient_registration.skip_to_manual_address! if form_matches_state?
        redirect_to_correct_form
      end
    end
  end
end
