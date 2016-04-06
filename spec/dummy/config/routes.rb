Rails.application.routes.draw do
  mount FloodRiskEngine::Engine => "/flood_risk_engine"
end
