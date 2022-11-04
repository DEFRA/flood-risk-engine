# frozen_string_literal: true

module FloodRiskEngine
  class ExemptionPresenter < BasePresenter
    def initialize(exemption)
      super(exemption, nil)
    end

    def radio_button_label
      "<strong>#{code}</strong> &ndash; #{summary} <span class='govuk-visually-hidden'>#{code}</span>".html_safe
    end
  end
end
