module FloodRiskEngine
  class Address < ApplicationRecord

    has_secure_token

    belongs_to :addressable, polymorphic: true
    has_one :location, as: :locatable, dependent: :restrict_with_exception

    after_create :clean_up_duplicate_addresses

    # Covers the RCDP Types
    #
    enum address_type: {
      primary: 0,
      secondary: 1,
      site: 2,
      contact: 3,
      billing: 4,
      principal_office: 5,
      principal_business: 6,
      registered_office: 7,
      partner: 8
    }

    def to_param
      token
    end

    def parts
      address_methods.collect { |m| send(m) }.reject(&:blank?)
    end

    def address_methods
      %i[premises street_address locality city postcode]
    end

    private

    def clean_up_duplicate_addresses
      return unless addressable.is_a?(FloodRiskEngine::Organisation) && address_type == "primary"

      primary_addresses = FloodRiskEngine::Address.where(addressable: addressable,
                                                         address_type: "primary")

      primary_addresses.each do |address|
        next if address == self
        address.delete
      end
    end
  end
end
