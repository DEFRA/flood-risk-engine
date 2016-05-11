module FloodRiskEngine
  class Location < ActiveRecord::Base
    belongs_to :locatable, polymorphic: true
  end
end
