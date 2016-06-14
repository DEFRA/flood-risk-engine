module FloodRiskEngine
  class Organisation < ActiveRecord::Base
    belongs_to :contact
    has_one :enrollment, dependent: :restrict_with_exception
    has_many :partners # Only needed for Partnerships

    enum org_type: {
      local_authority: 0,
      limited_company: 1,
      limited_liability_partnership: 2,
      individual: 3,
      partnership: 4,
      other: 5,
      unknown: 6
    }

    has_one :primary_address, -> { where(address_type: Address.address_types["primary"]) },
            class_name: "FloodRiskEngine::Address",
            as: :addressable,
            dependent: :restrict_with_exception

  end
end
