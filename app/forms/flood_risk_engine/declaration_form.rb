# frozen_string_literal: true

module FloodRiskEngine
  class DeclarationForm < ::FloodRiskEngine::BaseForm
    def self.can_navigate_flexibly?
      false
    end
  end
end
