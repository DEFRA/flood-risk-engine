# frozen_string_literal: true

module FloodRiskEngine
  class AddressPresenter

    def initialize(address)
      @address = address
    end

    # Returns a friendly single line representation of the address, e.g.
    # Flat 1A, 121 Acacia Avenue, Broadbean, Kent, TU4 8AA
    def to_single_line
      return unless address

      address.parts.join(", ")
    end

    private

    attr_reader :address
  end
end
