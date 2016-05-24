require "rails_helper"
module FloodRiskEngine
  describe Enrollments::StepsController, type: :controller do
    routes { Engine.routes }
    render_views
    let(:enrollment) { FactoryGirl.create(:enrollment, step: step) }

    context "grid_reference" do
      let(:step) { "grid_reference" }

      before do
        get :show, id: step, enrollment_id: enrollment
      end

      it "uses GridReferenceForm" do
        expect(controller.send(:form)).to be_a(Steps::GridReferenceForm)
      end

      it "diplays header" do
        header_text = t("flood_risk_engine.enrollments.steps.grid_reference.heading")
        expect(response.body).to have_tag :h1, text: /#{header_text}/
      end

      it "diplays Continue button" do
        expect(response.body).to have_selector("input[type=submit][value='Continue']")
      end
    end
  end
end
