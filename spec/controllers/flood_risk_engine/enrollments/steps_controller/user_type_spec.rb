require "rails_helper"
module FloodRiskEngine
  describe Enrollments::StepsController, type: :controller do
    routes { Engine.routes }
    render_views
    let(:enrollment) { FactoryGirl.create(:enrollment, step: step) }

    context "user_type" do
      let(:step) { "user_type" }

      it "uses UserTypeForm" do
        get :show, id: step, enrollment_id: enrollment
        expect(controller.send(:form)).to be_a(Steps::UserTypeForm)
      end
    end
  end
end
