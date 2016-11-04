#### Command (233)

Behavioral pattern, object behavioral

Encapsulates a request as an object, thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations.

##### Applicability

Use the Command pattern when you want to

 * parameterize objects by an action to perform, as MenuItem objects did above. You can express such parameterization in a procedural language with a callback function, that is, a function that's registered somewhere to be called at a later point. Commands are an object-oriented replacement for callbacks.
 * specify, queue, and execute requests at different times. A Command object can have a lifetime independent of the original request. If the receiver of a request can be represented in an address space-independent way, then you can transfer a command object for the request to a different process and fulfill the request there.
 * support undo. The Command's Execute operation can store state for reversing its effects in the command itself. The Command interface must have an added Unexecute operation that reverses the effects of a previous call to Execute. Executed commands are stored in a history list. Unlimited-level undo and redo is achieved by traversing this list backwards and forwards calling Unexecute and Execute, respectively.
 * support logging changes so that they can be reapplied in case of a system crash. By augmenting the Command interface with load and store operations, you can keep a persistent log of changes. Recovering from a crash involves reloading logged commands from disk and reexecuting them with the Execute operation.
 * structure a system around high-level operations built on primitives operations. Such a structure is common in information systems that support transactions. Atransaction encapsulates a set of changes to data. The Command pattern offers a way to model transactions. Commands have a common interface, letting you invoke all transactions the same way. The pattern also makes it easy to extend the system with new transactions.

##### Collaborations

 * The client creates a ConcreteCommand object and specifies its receiver.
 * An Invoker object stores the ConcreteCommand object.
 * The invoker issues a request by calling Execute on the command. When commands are undoable, ConcreteCommand stores state for undoing the command prior to invoking Execute.
 * The ConcreteCommand object invokes operations on its receiver to carry out the request.

##### Consequences

 1. Command decouples the object that invokes the operation from the one that knows how to perform it.
 2. Commands are first-class objects. They can be manipulated and extended like any other object.
 3. You can assemble commands into a composite command. An example is the MacroCommand class described earlier. In general, composite commands are an instance of the Composite (163) pattern.
 4. It's easy to add new Commands, because you don't have to change existing classes.

##### Related Patterns

A Composite (163) can be used to implement MacroCommands. A Memento (283) can keep state the command requires to undo its effect. A command that must be copied before being placed on the history list acts as a Prototype (117).
