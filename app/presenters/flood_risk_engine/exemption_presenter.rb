module FloodRiskEngine
  class ExemptionPresenter < BasePresenter
    def initialize(exemption)
      super(exemption, nil)
    end

    def radio_button_label
      "#{code} #{summary} <span class='govuk-visually-hidden'>#{code}</span>".html_safe
    end
  end
end
