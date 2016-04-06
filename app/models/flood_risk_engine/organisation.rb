module FloodRiskEngine
  class Organisation < ActiveRecord::Base
    belongs_to :contact
  end
end
