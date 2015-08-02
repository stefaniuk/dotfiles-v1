#### State (305)

Behavioral pattern, object behavioral

Allows an object to alter its behavior when its internal state changes. The object will appear to change its class.

##### Applicability

Use the State pattern in either of the following cases:

 * An object's behavior depends on its state, and it must change its behavior at run-time depending on that state.
 * Operations have large, multipart conditional statements that depend on the object's state. This state is usually represented by one or more enumerated constants. Often, several operations will contain this same conditional structure. The State pattern puts each branch of the conditional in a separate class. This lets you treat the object's state as an object in its own right that can vary independently from other objects.

##### Collaborations

 * Context delegates state-specific requests to the current ConcreteState object.
 * A context may pass itself as an argument to the State object handling the request. This lets the State object access the context if necessary.
 * Context is the primary interface for clients. Clients can configure a context with State objects. Once a context is configured, its clients don't have to deal with the State objects directly.
 * Either Context or the ConcreteState subclasses can decide which state succeeds another and under what circumstances.

##### Consequences

 * It localizes state-specific behavior and partitions behavior for different states
 * It makes state transitions explicit
 * State objects can be shared
 *

##### Related Patterns

The Flyweight (195) pattern explains when and how State objects can be shared. State objects are often Singletons (127).
