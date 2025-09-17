# frozen_string_literal: true

require_dependency "flood_risk_engine/application_controller"

module FloodRiskEngine
  class ErrorsController < ApplicationController

    before_action :set_html_response_format

    def show
      render(
        template: file_for(template),
        locals: { message: exception.try(:message), enrollment: },
        status: response_status
      )
    end

    protected

    # Changes the request format to HTML to always display the error pages
    def set_html_response_format
      request.format = :html
    end

    def response_status
      template.to_i.positive? ? template : :internal_server_error
    end

    def error_code
      @error_code ||= params[:id]
    end

    def template_exists?(name)
      File.exist? template_path(name)
    end

    def template_path(name)
      File.expand_path(
        "app/views/#{file_for(name)}.html.erb",
        FloodRiskEngine::Engine.root
      )
    end

    def template
      @template ||= if template_exists?(error_code)
                      error_code
                    else
                      (error_code.to_i.positive? ? "generic" : "404")
                    end
    end

    def file_for(name)
      "flood_risk_engine/errors/error_#{name}"
    end

    def exception
      ENV.fetch("action_dispatch.exception", nil)
    end

    def enrollment
      return unless journey_token

      Enrollment.find_by(token: journey_token)
    end

    def journey_token
      @journey_token ||= journey_tokens.last
    end

  end
end
