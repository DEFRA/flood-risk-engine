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
        let(:invalid_attributes) do
          { name: "12345 not a valid name **" }
        end

        it "assigns the enrollment as @enrollment" do
          put(:update, id: step, enrollment_id: enrollment)
          expect(assigns(:enrollment)).to eq(enrollment)
        end

        it "does not change the state" do
          put(:update, id: step, enrollment_id: enrollment)
          expect(assigns(:enrollment).step).to eq(step.to_s)
        end

        it "redirects back to show with check for errors" do
          put(:update, id: step, enrollment_id: enrollment, step => invalid_attributes)
          expect(response).to redirect_to(
            enrollment_step_path(enrollment, step, check_for_error: true)
          )
        end

        it "displays error on rendering show" do
          params = { id: step, enrollment_id: enrollment, check_for_error: true }
          session = { error_params: { step => invalid_attributes } }
          expected_error = I18n.t("flood_risk_engine.validation_errors.name.invalid")

          get(:show, params, session)
          expect(response.body).to have_tag :a, text: expected_error
        end
      end

      context "with large data in parameters" do
        let(:large_attributes) { { "name" => "foobar" * 500 } }

        before do
          put(:update, id: step, enrollment_id: enrollment, step => large_attributes)
        end

        it "should redirect back to current step with putting data into url" do
          expect(response).to redirect_to(
            enrollment_step_path(enrollment, step, check_for_error: true)
          )
        end

        it "should put the large data into session" do
          expect(session[:error_params]).to eq(step => large_attributes)
        end
      end
    end
  end
end
