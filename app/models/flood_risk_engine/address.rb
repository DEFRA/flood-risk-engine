module FloodRiskEngine
  class Address < ActiveRecord::Base
    belongs_to :addressable, polymorphic: true
    has_one :location, as: :locatable, dependent: :restrict_with_exception

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
      registered_office: 7
    }
  end
end
