FactoryBot.define do
  factory :location, class: FloodRiskEngine::Location do
    grid_reference { generate :grid_reference }
  end
end
