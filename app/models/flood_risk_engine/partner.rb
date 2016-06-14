module FloodRiskEngine
  class Partner < ActiveRecord::Base
    belongs_to :organisation
    belongs_to :contact

    delegate :full_name, :address, to: :contact
  end
end
