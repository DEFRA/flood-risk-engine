FloodRiskEngine::Engine.routes.draw do
  resources :enrollments, only: [:new, :create] do
    resources :steps, only: [:show, :update], controller: 'enrollments/steps'
  end
end
