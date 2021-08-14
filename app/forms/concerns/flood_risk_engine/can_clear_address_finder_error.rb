# frozen_string_literal: true

module FloodRiskEngine
  module CanClearAddressFinderError
    extend ActiveSupport::Concern

    included do
      attr_accessor :address_finder_error

      after_initialize :clear_address_finder_error

      private

      # Check if the user reached this page through an Address finder error.
      # Then wipe the temp attribute as we only need it for routing
      def clear_address_finder_error
        self.address_finder_error = transient_registration.address_finder_error
        transient_registration.update(address_finder_error: nil)
      end
    end
  end
end
