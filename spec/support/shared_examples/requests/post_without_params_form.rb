# frozen_string_literal: true

# When a user submits a form, that form must match the expected workflow_state.
# We don't adjust the state to match what the user is doing like we do for viewing forms.

# We expect to receive the name of the form (for example, location_form),
# a set of valid params, a set of invalid params, and an attribute to test persistence
# Default to :reg_identifier for forms which don't submit new data
RSpec.shared_examples "POST without params form" do |form|
  context "when the token is invalid" do
    it "redirects to the start page" do
      post_form_with_params(form, "foo")

      expect(response).to redirect_to(new_start_form_path)
    end
  end

  context "when a registration is in progress" do
    let(:transient_registration) do
      create(:new_registration)
    end

    context "when the workflow_state matches the requested form" do
      before do
        transient_registration.update(workflow_state: form)
      end

      context "when the params are valid" do
        it "changes the workflow_state and returns a 302 response" do
          state_before_request = transient_registration[:workflow_state]
          post_form_with_params(form, transient_registration.token)

          expect(transient_registration.reload[:workflow_state]).to_not eq(state_before_request)
          expect(response).to have_http_status(302)
        end
      end
    end

    context "when the workflow_state does not match the requested form" do
      before do
        # We need to pick a different but also valid state for the transient_registration
        # 'confirm_exemption_form' is the default, unless this would actually match!
        different_state = if form == "confirm_exemption_form"
                            "check_your_answers_form"
                          else
                            "confirm_exemption_form"
                          end
        transient_registration.update(workflow_state: different_state)
      end

      it "does not update the transient_registration or workflow_state, and redirects to the workflow_state" do
        transient_reg_before_submitting = transient_registration
        workflow_state = transient_registration[:workflow_state]

        post_form_with_params(form, transient_registration.token)

        expect(transient_registration.reload).to eq(transient_reg_before_submitting)
        expect(response).to redirect_to(new_path_for(workflow_state, transient_registration))
      end
    end
  end
end
