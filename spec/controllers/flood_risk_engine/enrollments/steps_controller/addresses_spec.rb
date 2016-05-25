require "rails_helper"
module FloodRiskEngine
  describe Enrollments::StepsController, type: :controller do
    routes { Engine.routes }
    render_views

    let(:enrollment) { FactoryGirl.create(:page_local_authority_address) }

    let(:reform_class) { Steps::LocalAuthorityAddressForm }

    let(:valid_post_code) { "BS1 5AH" }

    let(:header_text) {  t("#{reform_class.locale_key}.heading") }

    context "LocalAuthorityAddressForm" do
      let(:step) { :local_authority_address }

      before do
        mock_find_by_postcode
        get :show, id: step, enrollment_id: enrollment
      end

      it "uses LocalAuthorityAddressForm" do
        expect(controller.send(:form)).to be_a(reform_class)
      end

      it "diplays header" do
        expect(response.body).to have_tag :h1, text: /#{header_text}/
      end

      let(:match_initial_url_step) { /You are being <a href=\"\S+local_authority_address/ }

      context "with valid params" do
        let(:valid_attributes) {
          {
            "#{step}":
              {
                post_code: valid_post_code,
                uprn: "340116"
              }
          }
        }

        it "creates the address when valid UK UPRN supplied via drop down rendering process_address" do
          mock_find_by_uprn
          params = { id: step, enrollment_id: enrollment }.merge(valid_attributes)

          expect(enrollment.reload.organisation.primary_address).to_not be

          put(:update, params, session)

          expect(enrollment.reload.organisation.primary_address).to be

          expect(enrollment.organisation.primary_address.address_type).to eq "primary"
          expect(enrollment.organisation.primary_address.addressable_id).to eq enrollment.organisation.id
          expect(enrollment.organisation.primary_address.postcode).to eq valid_attributes[step][:post_code]
          expect(enrollment.organisation.primary_address.uprn.to_s).to eq valid_attributes[step][:uprn]

          expect(response).to redirect_to(enrollment_step_path(enrollment, enrollment.next_step))
        end
      end

      context "with invalid params" do
        let(:invalid_attributes) {
          {
            "#{step}":
              {
                uprn: "" # User clicks Continue before selecting an address from the Dropdown
              }
          }
        }

        let(:params) { { id: step, enrollment_id: enrollment }.merge(invalid_attributes) }

        it "assigns the enrollment as @enrollment" do
          put(:update, params, session)
          expect(assigns(:enrollment)).to eq(enrollment)
        end

        it "redirects back to show with check for errors when user doesn't select address from dropdown" do
          put(:update, params, session)
          expect(response).to redirect_to(
            enrollment_step_path(enrollment, step, check_for_error: true)
          )
        end

        it "displays blank error when user does not select address from dropdown" do
          params = { id: step, enrollment_id: enrollment, check_for_error: true }
          session = { error_params: { step => invalid_attributes } }

          get(:show, params, session)

          expected_error = I18n.t("flood_risk_engine.validation_errors.uprn.blank")
          expect(response.body).to have_tag :a, text: expected_error
        end

        it "does not change the state" do
          put(:update, params, session)
          expect(assigns(:enrollment).step).to eq(step.to_s)
        end
      end
    end
  end
end
