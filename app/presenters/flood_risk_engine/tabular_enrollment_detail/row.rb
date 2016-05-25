#
# Represents a row of summarize enrollment review data in for example the
# 'Check your answers' page or the confirmation email.
#
module FloodRiskEngine
  module TabularEnrollmentDetail
    class Row
      include Virtus.model
      attribute :name, Symbol         # eg :grid_reference
      attribute :title, String        # The title column e.g. 'Grid reference'
      attribute :change_link_suffix, String
      attribute :value                # The value e.g. the ST 123456 123456
      attribute :change_url, String # The Change link. Use Nil to prevent the link displaying
    end
  end
end
