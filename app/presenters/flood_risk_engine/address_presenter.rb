module FloodRiskEngine
  class AddressPresenter

    def initialize(address)
      @address = address
    end

    def to_s
      return unless address
      %i(premises street_address locality city postcode).map do |attribute|
        address[attribute]
      end.compact.join(",")
    end

    private

    attr_reader :address
  end
end
