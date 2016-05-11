module FloodRiskEngine
  class Address < ActiveRecord::Base
    belongs_to :addressable, polymorphic: true
    has_one :location, as: :locatable, dependent: :restrict_with_exception
  end
end
