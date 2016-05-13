module FloodRiskEngine
  module Reviewing
    module RowBuilders
      class GridReferenceRowBuilder < RowBuilders::Base
        def build
          Row.new(
            key: :grid_reference,
            title: row_t(:grid_reference, :title),
            value: enrollment_presenter.grid_reference,
            step_url: enrollment_step_path(enrollment, :grid_reference)
          )
        end
      end
    end
  end
end
