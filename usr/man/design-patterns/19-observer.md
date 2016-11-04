#### Observer (293)

Behavioral pattern, object behavioral

Defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.

##### Applicability

Use the Observer pattern in any of the following situations:

 * When an abstraction has two aspects, one dependent on the other. Encapsulating these aspects in separate objects lets you vary and reuse them independently.
 * When a change to one object requires changing others, and you don't know how many objects need to be changed.
 * When an object should be able to notify other objects without making assumptions about who these objects are. In other words, you don't want these objects tightly coupled.

##### Collaborations

 * ConcreteSubject notifies its observers whenever a change occurs that could make its observers' state inconsistent with its own.
 * After being informed of a change in the concrete subject, a ConcreteObserver object may query the subject for information. ConcreteObserver uses this information to reconcile its state with that of the subject.

##### Consequences

 * Abstract coupling between Subject and Observer
 * Support for broadcast communication
 * Unexpected updates

##### Related Patterns

Mediator (273): By encapsulating complex update semantics, the ChangeManager acts as mediator between subjects and observers. Singleton (127): The ChangeManager may use the Singleton pattern to make it unique and globally accessible.
