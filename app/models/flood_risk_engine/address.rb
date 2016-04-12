module FloodRiskEngine
  class Address < ActiveRecord::Base
    belongs_to :contact
    has_one :location
    has_one :enrollment, inverse_of: :site_address
  end
end
