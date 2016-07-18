# Flood Risk Engine's state machine

The role of the state machine in the Flood Risk Engine, is to control the work
flow through the multi-step form used to create enrollments. It allows an
enrollment to proceed to the next step without knowledge of what the next step
is. That is, the Enrollments Steps controller can call `enrollment.go_forward`
without having to know what the next steps is - the task of selecting the next
step is passed to the state machine.

There are three main components that provide the state machine functionality.

## Enrollment state machine

The core component is the state machine object `EnrollmentStateMachine` that
gets its functionality from the
[*finite_machine gem*](https://github.com/piotrmurach/finite_machine).
The main rules for how the state machine behaves are defined here.

With *finite_machine*, the rules are defined using a set of hashes defined on
an event, in this form:

```ruby
event :foo, :one => :two, :two => :three
```

This would define a `foo` event method, that when called would change the state
from `:one` to `:two` if the engine was at state `:one`; or from `:two` to `:three`
if the engine was at state `:two`.

Initially, the rules were built using these hashes, but this soon became
unwieldy, as there was a lot of repetition (the value from one change, being the
key in the next). Also almost all the state sequences shared a common set of
initial and final steps further adding to the repetition. Work flows were
introduced to simplify the rule definitions.

## Work Flows

The WorkFlow object takes a sequence of states (defined in arrays) and converts
them into the hashes used in the state machine rules. So for example, we could
define a sequence of states:

```ruby
class SomeWorkFlow < WorkFlow
  module Definitions
    def foo
      [:one, :two, :three]
    end
  end
end
```

Then the work flow can be used in the state machine `:foo` event definition:
```
event :foo, SomeWorkFlow.for(:foo)
```

This creates the same rule set as:
```ruby
event :foo, :one => :two, :two => :three
```

Most of the work flows share the same starting and finishing sequence of steps,
so using arrays made it simpler to share these sequences across multiple work
flows (see the `WorkFlow::Definitions#between_start_and_finish` method).

## The Step Machine

Using a state machine gem provided a lot of advantages - particularly in
simplifying the definition of the transition events `:go_forward` and `:go_back`.
However, the down side is that there are limitations on how a state machine's
behaviour can be directly modified and/or enhanced.

StepMachine is used as a wrapper, where methods can be defined that rename,
modify and/or combine state machine methods. One obvious modification is that
`states` become `steps` when returned by the step machine.

For example, the state machine's `restore!` method is renamed `set_step_as` in
the step machine. The step machine's `next_step` method uses the state machine's
methods to move the state forward, determine the new state, and then rewind back
to the current state, so as to return the name of the next step in the current
work flow.

The EnrollmentStateMachine instance is assigned to each enrollment via a
StepMachine instance. State machine methods are passed to the enrollment via
delegation. The StepMachine's `initialize` and `state_machine` methods are
designed to simplify the way a state machine is assigned to an enrollment.