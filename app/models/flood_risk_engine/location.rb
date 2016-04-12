module FloodRiskEngine
  class Location < ActiveRecord::Base
    belongs_to :address
  end
end
