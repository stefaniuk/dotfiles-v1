#### Flyweight (195)

Structural pattern, object structural

Uses sharing to support large numbers of fine-grained objects efficiently.

##### Applicability

The Flyweight pattern's effectiveness depends heavily on how and where it's used. Apply the Flyweight pattern when all of the following are true:

 * An application uses a large number of objects.
 * Storage costs are high because of the sheer quantity of objects.
 * Most object state can be made extrinsic.
 * Many groups of objects may be replaced by relatively few shared objects once extrinsic state is removed.
 * The application doesn't depend on object identity. Since flyweight objects may be shared, identity tests will return true for conceptually distinct objects.

##### Collaborations

 * State that a flyweight needs to function must be characterized as either intrinsic or extrinsic. Intrinsic state is stored in the ConcreteFlyweight object; extrinsic state is stored or computed by Client objects. Clients pass this state to the flyweight when they invoke its operations.
 * Clients should not instantiate ConcreteFlyweights directly. Clients must obtain ConcreteFlyweight objects exclusively from the FlyweightFactory object to ensure they are shared properly.

##### Consequences

 * Flyweights may introduce run-time costs
 * The more flyweights are shared, the greater the storage savings

##### Related Patterns

The Flyweight pattern is often combined with the Composite (163) pattern to implement a logically hierarchical structure in terms of a directed-acyclic graph with shared leaf nodes. It's often best to implement State (305) and Strategy (315) objects as flyweights.
