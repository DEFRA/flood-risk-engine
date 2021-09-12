# frozen_string_literal: true

module FloodRiskEngine
  class TransientRegistration < ApplicationRecord
    include CanHaveRegistrationAttributes

    self.table_name = "transient_registrations"

    has_many :transient_people, dependent: :destroy

    has_many :transient_registration_exemptions, dependent: :destroy
    has_many :exemptions, through: :transient_registration_exemptions

    has_one :company_address, -> { where(address_type: 1) }, as: :addressable,
                                                             class_name: "TransientAddress",
                                                             dependent: :destroy
    accepts_nested_attributes_for :company_address

    # HasSecureToken provides an easy way to generate unique random tokens for
    # any model in ruby on rails. We use it to uniquely identify an registration
    # by something other than it's db ID, or its reference number. We can then
    # use token instead of ID to identify an registration during the journey. The
    # format makes it sufficiently hard for another user to attempt to 'guess'
    # the token of another registration in order to see its details.
    # See https://github.com/robertomiranda/has_secure_token
    has_secure_token
    validates_presence_of :token, on: :save

    def last_partner
      transient_people.last
    end

    def completed_partners
      transient_people.select { |partner| partner.transient_address.present? }
    end

    def reference_number
      "TODO"
    end
  end
end
