# frozen_string_literal: true

module FloodRiskEngine
  class PartnerOverviewFormsController < ::FloodRiskEngine::FormsController
    def new
      super(PartnerOverviewForm, "partner_overview_form")
    end

    def create
      super(PartnerOverviewForm, "partner_overview_form")
    end

    def destroy
      partner = @transient_registration.transient_people.find(params[:partner_id])
      partner.destroy

      if @transient_registration.reload.completed_partners.empty?
        @transient_registration.update(workflow_state: "partner_name_form")
      end

      redirect_to_correct_form
    end
  end
end
