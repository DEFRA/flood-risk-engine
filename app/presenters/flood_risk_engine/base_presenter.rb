# frozen_string_literal: true

module FloodRiskEngine

  # The `BasePresenter` inherits from SimpleDelegator, and this allows us with
  # the line `super(model)` in the intializer to say any calls made on the
  # presenter which are not recognised, pass down to the model passed in. For
  # example if `CertificatePresenter` inherits `BasePresenter`, and we pass in
  # an instance of `Registration`, when it is instantiated you can call
  # `@presenter.company_name` without having to explicitly expose a method or
  # attribute on the `CertificatePresenter`.
  class BasePresenter < SimpleDelegator

    def initialize(model, view)
      @view = view
      super(model)
    end

    # Often in presenters you still want access to the helpers available to the
    # view (presenters sit between models and views). When you instantiate a
    # presenter you need to pass in the `view_context` from the relevant
    # controller or mailer. It can then access any helper methods available in
    # the view e.g. `link_to` by simply calling `h.link_to`. We expose the view
    # context through a method called `h()` as this is a standard pattern for
    # presenters.
    def h
      @view
    end
  end
end
