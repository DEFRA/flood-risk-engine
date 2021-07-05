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

    resources :confirm_exemption_forms,
              only: %i[new create],
              path: "confirm_exemption",
              path_names: { new: "" } do
                get "back",
                    to: "confirm_exemption_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :site_grid_reference_forms,
              only: %i[new create],
              path: "site-grid-reference",
              path_names: { new: "" } do
                get "back",
                    to: "site_grid_reference_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :business_type_forms,
              only: %i[new create],
              path: "business-type",
              path_names: { new: "" } do
                get "back",
                    to: "business_type_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :company_number_forms,
              only: %i[new create],
              path: "company-number",
              path_names: { new: "" } do
                get "back",
                    to: "company_number_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :company_name_forms,
              only: %i[new create],
              path: "company-name",
              path_names: { new: "" } do
                get "back",
                    to: "company_name_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :company_postcode_forms,
              only: %i[new create],
              path: "company-postcode",
              path_names: { new: "" } do
                get "back",
                    to: "company_postcode_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :company_address_lookup_forms,
              only: %i[new create],
              path: "company-address-lookup",
              path_names: { new: "" } do
                get "back",
                    to: "company_address_lookup_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :company_address_manual_forms,
              only: %i[new create],
              path: "company-address-manual",
              path_names: { new: "" } do
                get "back",
                    to: "company_address_manual_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :partner_name_forms,
              only: %i[new create],
              path: "partner-name",
              path_names: { new: "" } do
                get "back",
                    to: "partner_name_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :partner_postcode_forms,
              only: %i[new create],
              path: "partner-postcode",
              path_names: { new: "" } do
                get "back",
                    to: "partner_postcode_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :partner_address_lookup_forms,
              only: %i[new create],
              path: "partner-address-lookup",
              path_names: { new: "" } do
                get "back",
                    to: "partner_address_lookup_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :partner_address_manual_forms,
              only: %i[new create],
              path: "partner-address-manual",
              path_names: { new: "" } do
                get "back",
                    to: "partner_address_manual_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :partner_overview_forms,
              only: %i[new create],
              path: "partner-overview",
              path_names: { new: "" } do
                get "back",
                    to: "partner_overview_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :contact_name_forms,
              only: %i[new create],
              path: "contact-name",
              path_names: { new: "" } do
                get "back",
                    to: "contact_name_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :contact_phone_forms,
              only: %i[new create],
              path: "contact-phone",
              path_names: { new: "" } do
                get "back",
                    to: "contact_phone_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :contact_email_forms,
              only: %i[new create],
              path: "contact-email",
              path_names: { new: "" } do
                get "back",
                    to: "contact_email_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :additional_contact_email_forms,
              only: %i[new create],
              path: "additional-contact-email",
              path_names: { new: "" } do
                get "back",
                    to: "additional_contact_email_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :check_your_answers_forms,
              only: %i[new create],
              path: "check-your-answers",
              path_names: { new: "" } do
                get "back",
                    to: "check_your_answers_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :declaration_forms,
              only: %i[new create],
              path: "declaration",
              path_names: { new: "" } do
                get "back",
                    to: "declaration_forms#go_back",
                    as: "back",
                    on: :collection
              end

    resources :registration_complete_forms,
              only: %i[new create],
              path: "registration-complete",
              path_names: { new: "" }
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
