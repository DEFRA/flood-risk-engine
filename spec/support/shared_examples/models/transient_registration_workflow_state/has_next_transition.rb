# frozen_string_literal: true

RSpec.shared_examples "has next transition" do |next_state:|
  it "can transition to #{next_state}" do
    current_state = subject.workflow_state

    expect(subject).to transition_from(current_state).to(next_state).on_event(:next)
  end
end
