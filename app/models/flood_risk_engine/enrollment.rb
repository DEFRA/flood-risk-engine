require_dependency "has_secure_token"

module FloodRiskEngine
  class Enrollment < ApplicationRecord
    has_secure_token

    # We don't define the inverse relationship of applicant_contact as, in WEX at least,
    # we query never from contact to its enrollment
    belongs_to :applicant_contact, class_name: "Contact"
    belongs_to :organisation
    delegate :org_type, :partners, to: :organisation, allow_nil: true

    has_many :enrollment_exemptions,
             foreign_key: :enrollment_id,
             dependent: :restrict_with_exception
    has_many :exemptions,
             through: :enrollment_exemptions,
             dependent: :restrict_with_exception

    # The Correspondence Contact Details related to this Application a.k.a Main Contact
    belongs_to :correspondence_contact, class_name: "Contact"

    belongs_to :secondary_contact, class_name: "Contact"

    belongs_to :reference_number
    def reference_number
      super.try(:number)
    end

    has_one(
      :exemption_location,
      class_name: :Location,
      as: :locatable,
      dependent: :restrict_with_exception
    )

    has_one :address_search

    def to_param
      token
    end

    def submitted?
      submitted_at?
    end
  end
end
