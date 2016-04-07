Rails.application.routes.draw do
  resources :not_in_engines
  mount FloodRiskEngine::Engine => "/fre"
end
