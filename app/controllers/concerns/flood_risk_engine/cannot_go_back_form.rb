# frozen_string_literal: true

module FloodRiskEngine
  module CannotGoBackForm
    extend ActiveSupport::Concern

    included do
      # Override this method as user shouldn't be able to go back from this page
      def go_back
        raise ActionController::RoutingError, "Cannot go back"
      end
    end
  end
end
