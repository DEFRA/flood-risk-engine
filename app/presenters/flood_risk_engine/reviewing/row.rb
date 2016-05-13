#
# Represents a row of summarize enrollment review data in for example the
# 'Check your answers' page or the confirmation email.
#
module FloodRiskEngine
  module Reviewing
    class Row
      include Virtus.model
      attribute :key, Symbol        # eg :grid_reference
      attribute :title, String      # The title column e.g. 'Grid reference'
      attribute :value              # The value e.g. the ST 123456 123456
      attribute :step_url, String   # The Change link. Use Nil to prevent the link displaying
    end
  end
end
