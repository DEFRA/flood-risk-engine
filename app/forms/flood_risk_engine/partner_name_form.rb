# frozen_string_literal: true

module FloodRiskEngine
  class PartnerNameForm < ::FloodRiskEngine::BaseForm
    delegate :transient_people, to: :transient_registration

    attr_accessor :full_name

    validates :full_name, "flood_risk_engine/name_format": true

    def submit(params)
      # Assign the params for validation and pass them to the BaseForm method for updating
      self.full_name = params[:full_name]

      set_up_new_person if valid?

      super({})
    end

    private

    def set_up_new_person
      transient_people.build(full_name:)
    end
  end
end
