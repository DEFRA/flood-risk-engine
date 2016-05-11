module FloodRiskEngine
  class Location < ActiveRecord::Base
    has_one :address, as: :addressable
    belongs_to :locatable, polymorphic: true
  end
end
