FloodRiskEngine::Engine.routes.draw do
  resources :enrollments, only: [:new, :create] do
    resources :steps,      only: [:show, :update],  controller: "enrollments/steps"
    resources :exemptions, only: [:destroy, :show], controller: "enrollments/exemptions"
    resources :pages,      only: [:show],           controller: "enrollments/pages"
    resources(
      :addresses,
      only: [:new, :create, :edit, :update],
      controller: "enrollments/addresses"
    )
  end

  # See http://patrickperey.com/railscast-053-handling-exceptions/
  get "(errors)/:id", to: "errors#show", as: "error"
end
