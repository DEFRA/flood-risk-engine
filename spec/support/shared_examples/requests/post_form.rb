# frozen_string_literal: true

# When a user submits a form, that form must match the expected workflow_state.
# We don't adjust the state to match what the user is doing like we do for viewing forms.

# We expect to receive the name of the form (for example, location_form), and a set of options.
# Options can include valid params, invalid params, and an attribute to test persistence.
RSpec.shared_examples "POST form" do |form, options|
  let(:valid_params) { options[:valid_params] }
  let(:invalid_params) { options[:invalid_params] }

  context "when the params are valid" do
    it "updates the transient registration's workflow_state and returns a 302 http status" do
      state_before_request = transient_registration.workflow_state

      post_form_with_params(form, transient_registration.token, valid_params)

      transient_registration.reload

      expect(transient_registration.workflow_state).to_not eq(state_before_request)
      expect(response).to have_http_status(302)
    end
  end

  context "when the params are invalid" do
    it "does not update the transient registration's workflow_state, returns a 200 response and show the form again" do
      state_before_request = transient_registration.workflow_state

      post_form_with_params(form, transient_registration.token, invalid_params)

      transient_registration.reload

      expect(transient_registration.workflow_state).to eq(state_before_request)
      expect(response).to have_http_status(200)
      expect(response).to render_template("#{form}s/new")
    end
  end
end
