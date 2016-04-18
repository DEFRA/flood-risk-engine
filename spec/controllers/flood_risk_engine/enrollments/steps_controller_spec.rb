require "rails_helper"
module FloodRiskEngine
  describe Enrollments::StepsController, type: :controller do
    routes { Engine.routes }
    render_views

    let(:enrollment) { FactoryGirl.create(:enrollment) }

    context "grid_reference" do
      let(:step) { "grid_reference" }

      before do
        get :edit, step: step, id: enrollment
      end

      it "uses GridReferenceForm" do
        expect(controller.send(:form)).to be_a(Steps::GridReferenceForm)
      end

      it "diplays header" do
        header_text = "Where will the activity be located?" # TODO: change to i18n
        expect(response.body).to have_tag :h1, text: /#{header_text}/
      end
    end

    context "main contact name" do
      let(:step) { "main_contact_name" }

      it "uses MainContactNameForm" do
        get :edit, step: step, id: enrollment
        expect(controller.send(:form)).to be_a(Steps::MainContactNameForm)
      end
    end

    context "user_type" do
      let(:step) { "user_type" }

      it "uses UserTypeForm" do
        get :edit, step: step, id: enrollment
        expect(controller.send(:form)).to be_a(Steps::UserTypeForm)
      end
    end

    context "step unknown" do
      let(:step) { "unknown" }

      it "uses GridReferenceForm" do
        expect do
          get :edit, step: step, id: enrollment
        end.to raise_error(StandardError)
      end
    end
  end
end
