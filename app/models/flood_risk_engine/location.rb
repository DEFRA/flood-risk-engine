module FloodRiskEngine
  class Location < ActiveRecord::Base
    has_one :address, as: :addressable
  end
end
