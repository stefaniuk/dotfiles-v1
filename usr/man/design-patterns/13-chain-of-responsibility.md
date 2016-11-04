#### Chain of Responsibility (223)

Behavioral pattern, object behavioral

Avoids coupling the sender of a request to its receiver by giving more than one object a chance to handle the request. Chains the receiving objects and pass the request along the chain until an object handles it.

##### Applicability

Use Chain of Responsibility when

 * more than one object may handle a request, and the handler isn't known a priori. The handler should be ascertained automatically.
 * you want to issue a request to one of several objects without specifying the receiver explicitly.
 * the set of objects that can handle a request should be specified dynamically.

##### Collaborations

 * When a client issues a request, the request propagates along the chain until a ConcreteHandler object takes responsibility for handling it.

##### Consequences

 * Reduced coupling
 * Added flexibility in assigning responsibilities to objects
 * Receipt isn't guaranteed

##### Related Patterns

Chain of Responsibility is often applied in conjunction with Composite (163). There, a component's parent can act as its successor.
