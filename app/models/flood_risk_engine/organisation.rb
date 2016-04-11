module FloodRiskEngine
  class Organisation < ActiveRecord::Base
    belongs_to :contact
    has_one :enrollment, dependent: :restrict_with_exception

    TYPES = [
      OrganisationTypes::LocalAuthority,
      OrganisationTypes::LimitedCompany,
      OrganisationTypes::LimitedLiabilityPartnership,
      OrganisationTypes::Individual,
      OrganisationTypes::Other,
      OrganisationTypes::Unknown
    ].freeze
  end
end
