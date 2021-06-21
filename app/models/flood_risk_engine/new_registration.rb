# frozen_string_literal: true

module FloodRiskEngine
  class NewRegistration < TransientRegistration
    include CanUseNewRegistrationWorkflow
  end
end
