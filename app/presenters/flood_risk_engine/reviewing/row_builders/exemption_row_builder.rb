module FloodRiskEngine
  module Reviewing
    module RowBuilders
      class ExemptionRowBuilder < RowBuilders::Base
        def build(exemption)
          Row.new(
            key: :exemption,
            title: row_t(:exemption, :title, code: exemption.code),
            value: exemption.summary,
            step_url: enrollment_step_path(enrollment, :check_exemptions)
          )
        end
      end
    end
  end
end
