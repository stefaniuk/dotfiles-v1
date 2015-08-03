#### Strategy (315)

Behavioral pattern, object behavioral

Defines a family of algorithms, encapsulates each one, and makes them interchangeable. Strategy lets the algorithm vary independently from clients that use it.

##### Applicability

Use the Strategy pattern when

 * many related classes differ only in their behavior. Strategies provide a way to configure a class with one of many behaviors.
 * you need different variants of an algorithm. For example, you might define algorithms reflecting different space/time trade-offs. Strategies can be used when these variants are implemented as a class hierarchy of algorithms.
 * an algorithm uses data that clients shouldn't know about. Use the Strategy pattern to avoid exposing complex, algorithm-specific data structures.
 * a class defines many behaviors, and these appear as multiple conditional statements in its operations. Instead of many conditionals, move related conditional branches into their own Strategy class.

##### Collaborations

 * Strategy and Context interact to implement the chosen algorithm. A context may pass all data required by the algorithm to the strategy when the algorithm is called. Alternatively, the context can pass itself as an argument to Strategy operations. That lets the strategy call back on the context as required.
 * A context forwards requests from its clients to its strategy. Clients usually create and pass a ConcreteStrategy object to the context; thereafter, clients interact with the context exclusively. There is often a family of ConcreteStrategy classes for a client to choose from.

##### Consequences

 * Families of related algorithms
 * An alternative to subclassing
 * Strategies eliminate conditional statements
 * A choice of implementations
 * Clients must be aware of different Strategies
 * Communication overhead between Strategy and Context
 * Increased number of objects

##### Related Patterns

Flyweight (195): Strategy objects often make good flyweights.
