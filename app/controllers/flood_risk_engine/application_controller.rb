# frozen_string_literal: true

module FloodRiskEngine
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    layout ->(_) { FloodRiskEngine.config.layout }

    rescue_from StandardError do |e|
      Airbrake.notify e
      Rails.logger.error "Unhandled exception: #{e}\n#{e.backtrace}"
      redirect_to error_path("500")
    end

    protected

    # http://jacopretorius.net/2014/01/force-page-to-reload-on-browser-back-in-rails.html
    def back_button_cache_buster
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

    def journey_tokens
      @journey_tokens ||= cookies.encrypted[:journey_token].try(:split, ",") || []
    end
  end
end
