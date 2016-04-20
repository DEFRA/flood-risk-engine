FloodRiskEngine::Engine.routes.draw do
  resources :enrollments

  # Copied from dummy app - may be out of date now
  resources :enrollments, only: [:new, :create] do
    resources :steps, only: [:show, :update], controller: "enrollments/steps"
  end

  root to: "enrollments#new"
end
