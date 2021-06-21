# frozen_string_literal: true

RSpec.shared_examples "a fixed final state" do |current_state:, factory:|
  context "when a subject's state is #{current_state}" do
    subject(:subject) { create(factory, workflow_state: current_state) }

    context "when a subject's state is #{current_state}" do
      it "can not transition to any states" do
        permitted_states = Helpers::WorkflowStates.permitted_states(subject)
        expect(permitted_states).to be_empty
      end
    end
  end
end
