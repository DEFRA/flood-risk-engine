# frozen_string_literal: true

RSpec.shared_examples "a simple bidirectional transition" do |previous_state:, current_state:, next_state:, factory:|
  context "when a subject's state is #{current_state}" do
    subject(:subject) { create(factory, workflow_state: current_state) }

    it "can only transition to either #{previous_state} or #{next_state}" do
      permitted_states = Helpers::WorkflowStates.permitted_states(subject)
      expect(permitted_states).to match_array([previous_state, next_state])
    end

    it "changes to #{next_state} after the 'next' event" do
      expect(subject).to transition_from(current_state).to(next_state).on_event(:next)
    end

    it "changes to #{previous_state} after the 'back' event" do
      expect(subject).to transition_from(current_state).to(previous_state).on_event(:back)
    end
  end
end
