module FloodRiskEngine
  module Steps
    class BaseRedirectableForm < BaseForm

      attr_accessor :redirection_url
      attr_accessor :redirect
      alias redirect? redirect

      include FloodRiskEngine::Engine.routes.url_helpers

    end
  end
end
