#### Adapter (139)

Structural pattern, class/object structural

Converts the interface of a class into another interface clients expect. Adapter lets classes work together that couldn't otherwise because of incompatible interfaces.

##### Applicability

Use the Adapter pattern when

 * you want to use an existing class, and its interface does not match the one you need.
 * you want to create a reusable class that cooperates with unrelated or unforeseen classes, that is, classes that don't necessarily have compatible interfaces.
 * (object adapter only) you need to use several existing subclasses, but it's impractical to adapt their interface by subclassing every one. An object adapter can adapt the interface of its parent class.

##### Collaborations

 * Clients call operations on an Adapter instance. In turn, the adapter calls Adaptee operations that carry out the request.

##### Consequences

 * How much adapting does Adapter do
 * Pluggable adapters
 * Using two-way adapters to provide transparency

##### Related Patterns

Bridge (151) has a structure similar to an object adapter, but Bridge has a different intent: It is meant to separate an interface from its implementation so that they can be varied easily and independently. An adapter is meant to change the interface of an existing object. Decorator (175) enhances another object without changing its interface. A decorator is thus more transparent to the application than an adapter is. As a consequence, Decorator supports recursive composition, which isn't possible with pure adapters. Proxy (207) defines a representative or surrogate for another object and does not change its interface.
