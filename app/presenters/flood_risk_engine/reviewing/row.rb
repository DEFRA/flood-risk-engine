#
# Represents a row of summarize enrollment review data in for example the
# 'Check your answers' page or the confirmation email.
#
module FloodRiskEngine
  module Reviewing
    class Row
      include Virtus.model
      attribute :name, Symbol # eg :grid_reference
      attribute :title, String      # The title column e.g. 'Grid reference'
      attribute :value              # The value e.g. the ST 123456 123456
      attribute :step_url, String   # The Change link. Use Nil to prevent the link displaying

      # def new(name:,
      #         value:,
      #         step: nil,
      #         display_step_url: true,
      #         **t_options)
      #   step ||= name
      #   Row.new(
      #     key: name,
      #     title: row_t(name, :title, t_options),
      #     value: value,
      #     step_url: (url_for_step(step.to_sym) if display_step_url)
      #   )
      # end

      # def new(name, value, options)
      #   @name = name
      #   @title = row_t(name, :title, t_options),
      # end

    end
  end
end
