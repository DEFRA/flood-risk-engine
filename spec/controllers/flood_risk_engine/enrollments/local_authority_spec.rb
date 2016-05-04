require "rails_helper"
module FloodRiskEngine
  describe Enrollments::StepsController, type: :controller do
    routes { Engine.routes }
    render_views

    let(:enrollment) { FactoryGirl.create(:enrollment, step: step) }

    let(:reform_class) { Steps::LocalAuthorityForm }

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

      context "with invalid params" do
        let(:invalid_attributes) {
          { name: "12345 not a valid name **" }
        }

        it "assigns the enrollment as @enrollment" do
          put(:update, id: step, enrollment_id: enrollment)
          expect(assigns(:enrollment)).to eq(enrollment)
        end

        it "does not change the state" do
          put(:update, id: step, enrollment_id: enrollment)
          expect(assigns(:enrollment).step).to eq(step.to_s)
        end

        it "does not update enrollment with local_authority Name" do
          put(:update, id: step, enrollment_id: enrollment, step => invalid_attributes)

          # HTML will contain something like
          # <a class="error-text" href="#form_group_name">Enter the name of the local authority or public body</a>
          expected_error = I18n.t("flood_risk_engine.validation_errors.name.invalid")

          pending "response says you are being redirected - not sure how to test validations in these tests"
          expect(response.body).to have_tag :a, text: expected_error
        end
      end
    end
  end
end
