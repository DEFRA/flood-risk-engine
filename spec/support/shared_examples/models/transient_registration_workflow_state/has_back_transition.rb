# frozen_string_literal: true

RSpec.shared_examples "has back transition" do |previous_state:|
  it "can transition to #{previous_state}" do
    current_state = subject.workflow_state

    expect(subject).to transition_from(current_state).to(previous_state).on_event(:back)
  end
end
