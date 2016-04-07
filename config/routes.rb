FloodRiskEngine::Engine.routes.draw do
  resources :enrollments, only: [:new] do
    #resources :steps, only: [:edit, :update], controller: 'enrollments/steps', to: '#edit'

    member do
      get "steps/:step",
          to: 'enrollments/steps#edit',
          as: "build_step"

      patch "steps/:step",
            to: 'enrollments/steps#update',
            as: "update_step"
    end
    # member do
    #   # url_for([:edit, enrollment, step: 'step1'])
    #   # or
    #   # edit_step_enrollment(enrollment, enrollment.state)
    #   get 'steps/:step', to: '#edit', as: 'edit_step'

    #   # url_for([:update, enrollment, step: 'step1'])
    #   # or
    #   # update_step_enrollment(enrollment, enrollment.state)
    #   patch 'steps/:step', to: '#update', as: 'update_step'
    # end
  end
  root to: "enrollments#new"
end
