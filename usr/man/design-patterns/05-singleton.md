#### Singleton (127)

Creational pattern, object creational

Ensures a class only has one instance, and provides a global point of access to it.

##### Applicability

Use the Singleton pattern when

 * there must be exactly one instance of a class, and it must be accessible to clients from a well-known access point.
 * when the sole instance should be extensible by subclassing, and clients should be able to use an extended instance without modifying their code.

##### Collaborations

 * Clients access a Singleton instance solely through Singleton's Instance operation.

##### Consequences

 * Controlled access to sole instance
 * Reduced name space
 * Permits refinement of operations and representation
 * Permits a variable number of instances
 * More flexible than class operations

##### Related Patterns

Many patterns can be implemented using the Singleton pattern. See Abstract Factory (87), Builder (97), and Prototype (117).
