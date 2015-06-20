#### Bridge (151)

Structural pattern, object structural

Decouples an abstraction from its implementation so that the two can vary independently.

##### Applicability

Use the Bridge pattern when

 * you want to avoid a permanent binding between an abstraction and its implementation. This might be the case, for example, when the implementation must be selected or switched at run-time.
 * both the abstractions and their implementations should be extensible by subclassing. In this case, the Bridge pattern lets you combine the different abstractions and implementations and extend them independently.
 * changes in the implementation of an abstraction should have no impact on clients; that is, their code should not have to be recompiled.
 * (C++) you want to hide the implementation of an abstraction completely from clients. In C++ the representation of a class is visible in the class interface.
 * you have a proliferation of classes. Such a class hierarchy indicates the need for splitting an object into two parts.
 * you want to share an implementation among multiple objects (perhaps using reference counting), and this fact should be hidden from the client.

##### Collaborations

 * Abstraction forwards client requests to its Implementor object.

##### Consequences

 * Decoupling interface and implementation
 * Improved extensibility
 * Hiding implementation details from clients

##### Related Patterns

An Abstract Factory (87) can create and configure a particular Bridge. The Adapter (139) pattern is geared toward making unrelated classes work together. It is usually applied to systems after they're designed. Bridge, on the other hand, is used up-front in a design to let abstractions and implementations vary independently.
