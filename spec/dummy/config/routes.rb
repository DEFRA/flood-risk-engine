Rails.application.routes.draw do
  resources :not_in_engines
  mount FloodRiskEngine::Engine => "/"
  root to: "flood_risk_engine/enrollments#new"
end
