module FloodRiskEngine
  class Address < ActiveRecord::Base
    belongs_to :contact
  end
end
