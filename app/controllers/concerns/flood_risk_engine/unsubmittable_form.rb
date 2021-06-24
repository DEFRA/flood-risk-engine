# frozen_string_literal: true

module FloodRiskEngine
  module UnsubmittableForm
    extend ActiveSupport::Concern

    included do
      # Override this method as user shouldn't be able to "submit" this page
      def create
        raise ActionController::RoutingError, "Unsubmittable"
      end
    end
  end
end
