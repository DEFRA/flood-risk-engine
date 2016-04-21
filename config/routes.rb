FloodRiskEngine::Engine.routes.draw do
  # Copied from dummy app - may be out of date now
  resources :enrollments, only: [:new, :create] do
    resources :steps, only: [:show, :update], controller: "enrollments/steps"
  end
end
