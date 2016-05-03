require "rails_helper"
module FloodRiskEngine
  describe Enrollments::StepsController, type: :controller do

    routes { Engine.routes }
    render_views

    let(:enrollment) { FactoryGirl.create(:page_correspondence_contact_name) }

    let(:reform_class) { Steps::CorrespondenceContactNameForm }

    context "CorrespondenceContact Name " do
      let(:step) { :correspondence_contact_name }

      before do
        get :show, id: step, enrollment_id: enrollment
      end

      it "uses CorrespondenceContactNameForm" do
        expect(controller.send(:form)).to be_a(reform_class)
      end

      it "diplays header" do
        header_text = t("#{reform_class.locale_key}.heading")
        expect(response.body).to have_tag :h1, text: /#{header_text}/
      end

      context "with invalid params" do

        let(:invalid_attributes) {
          { full_name: "12345 not a valid name **" }
        }

        it "assigns the enrollment as @enrollment" do
          put(:update, id: step, enrollment_id: enrollment)
          expect(assigns(:enrollment)).to eq(enrollment)
        end

        it "does not change the state" do
          put(:update, id: step, enrollment_id: enrollment)
          expect(assigns(:enrollment).step).to eq(step.to_s)
        end

        it "does not update enrollment with contact name" do
          put(:update, id: step, enrollment_id: enrollment, step => invalid_attributes)

          # HTML will contain something like
          # <a class="error-text" href="#form_group_name">Enter the name of the local authority or public body</a>
          expected_error = I18n.t("flood_risk_engine.validation_errors.full_name.invalid")

          pending "response just says you are being redirected - feature tests would be better than these tests"
          expect(response.body).to have_tag :a, text: expected_error
        end

      end
    end
  end
end
