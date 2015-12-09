#### Memento (283)

Behavioral pattern, object behavioral

Without violating encapsulation, captures and externalizes an object's internal state so that the object can be restored to this state later.

##### Applicability

Use the Memento pattern when

 * a snapshot of (some portion of) an object's state must be saved so that it can be restored to that state later, and
 * a direct interface to obtaining the state would expose implementation details and break the object's encapsulation.

##### Collaborations

 * A caretaker requests a memento from an originator, holds it for a time, and  passes it back to the originator. Sometimes the caretaker won't pass the memento back to the originator, because the originator might never need to revert to an earlier state.
 * Mementos are passive. Only the originator that created a memento will assign or retrieve its state.

##### Consequences

 * Preserving encapsulation boundaries
 * It simplifies Originator
 * Using mementos might be expensive
 * Defining narrow and wide interfaces
 * Hidden costs in caring for mementos

##### Related Patterns

Command (233): Commands can use mementos to maintain state for undoable operations. Iterator (257): Mementos can be used for iteration as described earlier.
