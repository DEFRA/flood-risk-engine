module FloodRiskEngine
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    layout ->(_) { "application" }

    # http://jacopretorius.net/2014/01/force-page-to-reload-on-browser-back-in-rails.html
    def back_button_cache_buster
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
  end
end
