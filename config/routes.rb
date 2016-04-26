FloodRiskEngine::Engine.routes.draw do
  resources :enrollments, only: [:new, :create] do
    resources :steps, only: [:show, :update], controller: "enrollments/steps"

    member do
      get(
        "remove_exemption/:exemption_id",
        controller: "enrollments/steps",
        action: "remove_exemption",
        as: "remove_exemption"
      )
    end
  end
end
