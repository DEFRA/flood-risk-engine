FloodRiskEngine::Engine.routes.draw do
  resources :start_forms,
            only: %i[new create],
            path: "start",
            path_names: { new: "" }

  scope "/:token" do
    # New registration flow
    resources :exemption_forms,
              only: %i[new create],
              path: "exemption",
              path_names: { new: "" } do
                get "back",
                    to: "exemption_forms#go_back",
                    as: "back",
                    on: :collection
              end
  end

  resources :enrollments, only: [:new, :create] do
    resources :steps,      only: [:show, :update],  controller: "enrollments/steps"
    resources :exemptions, only: [:destroy, :show], controller: "enrollments/exemptions"
    resources :pages,      only: [:show],           controller: "enrollments/pages"

    resources(
      :partners, only: [:destroy, :show, :edit], controller: "enrollments/partners"
    ) do
      post "destroy", as: :delete, on: :member # required for deletion form on :show
    end

    resources(
      :addresses,
      only: [:new, :create, :edit, :update],
      controller: "enrollments/addresses"
    )
  end

  mount DefraRubyEmail::Engine => "/email"

  # See http://patrickperey.com/railscast-053-handling-exceptions/
  get "(errors)/:id", to: "errors#show", as: "error"
end
