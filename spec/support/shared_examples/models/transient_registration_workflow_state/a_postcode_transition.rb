# frozen_string_literal: true

RSpec.shared_examples "a postcode transition" do |previous_state:, address_type:, factory:|
  describe "#workflow_state" do
    current_state = :"#{address_type}_postcode_form"
    subject(:form) { create(factory, workflow_state: current_state) }

    context "when form.skip_to_manual_address? is false" do
      next_state = :"#{address_type}_address_lookup_form"
      alt_state = :"#{address_type}_address_manual_form"

      it "can only transition to either #{previous_state}, #{next_state}, or #{alt_state}" do
        permitted_states = Helpers::WorkflowStates.permitted_states(form)
        expect(permitted_states).to contain_exactly(previous_state, next_state, alt_state)
      end

      it "changes to #{next_state} after the 'next' event" do
        expect(form.send(:skip_to_manual_address?)).to be(false)
        expect(form).to transition_from(current_state).to(next_state).on_event(:next)
      end

      it "changes to #{alt_state} after the 'skip_to_manual_address' event" do
        expect(form.send(:skip_to_manual_address?)).to be(false)
        expect(form)
          .to transition_from(current_state)
          .to(alt_state)
          .on_event(:skip_to_manual_address)
      end
    end

    context "when form.skip_to_manual_address? is true" do
      next_state = :"#{address_type}_address_manual_form"

      before { allow(form).to receive(:address_finder_error).and_return(true) }

      it "can only transition to either #{previous_state} or #{next_state}" do
        permitted_states = Helpers::WorkflowStates.permitted_states(form)
        expect(permitted_states).to contain_exactly(previous_state, next_state)
      end

      it "changes to #{next_state} after the 'next' event" do
        expect(form.send(:skip_to_manual_address?)).to be(true)
        expect(form).to transition_from(current_state).to(next_state).on_event(:next)
      end
    end

    it "changes to #{previous_state} after the 'back' event" do
      expect(form).to transition_from(current_state).to(previous_state).on_event(:back)
    end
  end
end
