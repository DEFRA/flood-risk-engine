# frozen_string_literal: true

# A 'locked-in' form is a form we definitely don't want users to access out-of-order,
# for example, by clicking the back button or URL-hacking.
# Users shouldn't be able to get into locked-in forms this way.
# They also shouldn't be able to get out of them, except by using buttons within the app.
# This prevents users from skipping past the declaration stage, or trying to go back and
# make changes to their information after they've completed a registration.
RSpec.shared_examples "GET locked-in form" do |form|
  context "when a registration is in progress" do
    let(:transient_registration) do
      create(:new_registration)
    end

    context "when the workflow_state matches the requested form" do
      before do
        transient_registration.update(workflow_state: form)
      end

      it "loads the form and does not change the workflow_state" do
        state_before_request = transient_registration[:workflow_state]

        get new_path_for(form, transient_registration)

        expect(response).to have_http_status(200)
        expect(transient_registration.reload[:workflow_state]).to eq(state_before_request)
      end
    end

    context "when the workflow_state is a flexible form" do
      before do
        transient_registration.update(workflow_state: "contact_name_form")
      end

      it "does not change the workflow_state and redirects to the saved workflow_state" do
        workflow_state = transient_registration[:workflow_state]

        get new_path_for(form, transient_registration)

        expect(transient_registration.reload[:workflow_state]).to eq(workflow_state)
        expect(response).to redirect_to(new_path_for(workflow_state, transient_registration))
      end
    end

    context "when the workflow_state is a locked-in form" do
      before do
        # We need to pick a different but also valid state for the transient_registration
        # 'declaration_form' is the default, unless this would actually match!
        different_state = if form == "declaration_form"
                            "registration_complete_form"
                          else
                            "declaration_form"
                          end
        transient_registration.update(workflow_state: different_state)
      end

      it "does not change the workflow_state and redirects to the saved workflow_state" do
        workflow_state = transient_registration[:workflow_state]

        get new_path_for(form, transient_registration)

        expect(transient_registration.reload[:workflow_state]).to eq(workflow_state)
        expect(response).to redirect_to(new_path_for(workflow_state, transient_registration))
      end
    end
  end

  # Should call a method like new_location_form_path("CBDU1234")
  def new_path_for(form, transient_registration)
    public_send("new_#{form}_path", transient_registration.token)
  end
end
