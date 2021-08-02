# frozen_string_literal: true

module FloodRiskEngine
  class ExemptionForm < ::FloodRiskEngine::BaseForm
    attr_accessor :exemption_ids

    delegate :exemptions, to: :transient_registration

    validates :exemptions, "flood_risk_engine/exemptions": true

    after_initialize :assign_existing_exemption

    def all_exemptions
      @_all_exemptions ||= Exemption.all.map do |exemption|
        ExemptionPresenter.new(exemption)
      end
    end

    private

    def assign_existing_exemption
      return unless exemptions.any?

      self.exemption_ids = exemptions.first.id
    end
  end
end
