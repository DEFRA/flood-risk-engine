# frozen_string_literal: true

module FloodRiskEngine
  class Partner < ApplicationRecord
    belongs_to :organisation, optional: true
    belongs_to :contact, optional: true

    delegate :full_name, :address, to: :contact

    after_save do
      organisation.try(:update_searchable_content)
    end
  end
end
