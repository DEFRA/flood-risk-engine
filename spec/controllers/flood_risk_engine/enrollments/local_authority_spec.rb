require "rails_helper"
module FloodRiskEngine
  describe Enrollments::StepsController, type: :controller do
    routes { Engine.routes }
    render_views

    let(:enrollment) { FactoryGirl.create(:enrollment, step: step) }

    context "local_authority" do
      let(:step) { :local_authority }

      before do
        get :show, id: step, enrollment_id: enrollment
      end

      it "uses LocalAuthorityForm" do
        expect(controller.send(:form)).to be_a(Steps::LocalAuthorityForm)
      end

      it "diplays header" do
        header_text = t("flood_risk_engine.enrollments.steps.local_authority.heading")
        expect(response.body).to have_tag :h1, text: /#{header_text}/
      end
    end
  end
end
