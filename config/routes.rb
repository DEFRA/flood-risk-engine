FloodRiskEngine::Engine.routes.draw do
  resources :enrollments, only: [:new, :create] do
    resources :steps, only: [:show, :update], controller: "enrollments/steps" do
    end

    resources :exemptions, only: [:destroy, :show], controller: "enrollments/exemptions"
  end

end
