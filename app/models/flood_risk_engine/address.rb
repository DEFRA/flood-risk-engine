module FloodRiskEngine
  class Address < ActiveRecord::Base
    belongs_to :contact
    has_one :location, dependent: :restrict_with_exception
    has_one :enrollment, inverse_of: :site_address, dependent: :restrict_with_exception
  end
end
