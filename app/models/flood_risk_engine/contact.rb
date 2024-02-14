# frozen_string_literal: true

require "validates_email_format_of"

module FloodRiskEngine
  class Contact < ApplicationRecord
    has_one :organisation, dependent: :restrict_with_exception
    has_one :address, as: :addressable, dependent: :restrict_with_exception

    enum contact_type: {
      individual: 0,
      partner: 1,
      employee: 2,
      applicant: 3,
      correspondence: 4,
      operation: 5,
      establishment_or_undertaking: 6
    }

    # Derived from RCDP customer data model
    enum title: { "na" => 0, "Mr" => 1, "Mrs" => 2, "Miss" => 3, "Ms" => 4, "Dr" => 5, "Rev" => 6, "Sir" => 7,
                  "Lady" => 8, "Lord" => 9, "Captain" => 10, "Major" => 11, "Professor" => 12, "Dame" => 13,
                  "Colonel" => 14 }

    after_save do
      organisation.try(:update_searchable_content)
    end

  end
end
