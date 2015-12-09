#### Composite (163)

Structural pattern, object structural

Composes objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly.

##### Applicability

Use the Composite pattern when

 * you want to represent part-whole hierarchies of objects.
 * you want clients to be able to ignore the difference between compositions of objects and individual objects. Clients will treat all objects in the composite structure uniformly.

##### Collaborations

 * Clients use the Component class interface to interact with objects in the composite structure. If the recipient is a Leaf, then the request is handled directly. If the recipient is a Composite, then it usually forwards requests to its child components, possibly performing additional operations before and/or after forwarding.

##### Consequences

 * Defines class hierarchies consisting of primitive objects and composite objects
 * Makes the client simple
 * Makes it easier to add new kinds of components
 * Can make your design overly general

##### Related Patterns

Often the component-parent link is used for a Chain of Responsibility (223). Decorator (175) is often used with Composite. When decorators and composites are used together, they will usually have a common parent class. So decorators will have to support the Component interface with operations like Add, Remove, and GetChild. Flyweight (195) lets you share components, but they can no longer refer to their parents. Iterator (257) can be used to traverse composites. Visitor (331) localizes operations and behavior that would otherwise be distributed across Composite and Leaf classes.
