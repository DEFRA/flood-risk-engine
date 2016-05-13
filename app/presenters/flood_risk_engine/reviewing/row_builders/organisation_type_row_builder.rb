module FloodRiskEngine
  module Reviewing
    module RowBuilders
      class OrganisationTypeRowBuilder < RowBuilders::Base
        def build
          Row.new(
            key: :organisation_type,
            title: row_t(:organisation_type, :title),
            value: enrollment_presenter.organisation_type,
            step_url: nil
          )
        end
      end
    end
  end
end
