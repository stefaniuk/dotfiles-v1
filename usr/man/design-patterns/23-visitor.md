#### Visitor (331)

Behavioral pattern, object behavioral

Represents an operation to be performed on the elements of an object structure. Visitor lets you define a new operation without changing the classes of the elements on which it operates.

##### Applicability

Use the Visitor pattern when

 * an object structure contains many classes of objects with differing interfaces, and you want to perform operations on these objects that depend on their concrete classes.
 * many distinct and unrelated operations need to be performed on objects in an object structure, and you want to avoid "polluting" their classes with these operations. Visitor lets you keep related operations together by defining them in one class. When the object structure is shared by many applications, use Visitor to put operations in just those applications that need them.
 * the classes defining the object structure rarely change, but you often want to define new operations over the structure. Changing the object structure classes requires redefining the interface to all visitors, which is potentially costly. If the object structure classes change often, then it's probably better to define the operations in those classes.

##### Collaborations

 * A client that uses the Visitor pattern must create a ConcreteVisitor object and then traverse the object structure, visiting each element with the visitor.
 * When an element is visited, it calls the Visitor operation that corresponds to its class. The element supplies itself as an argument to this operation to let the visitor access its state, if necessary.

##### Consequences

 * Visitor makes adding new operations easy
 * A visitor gathers related operations and separates unrelated ones
 * Adding new ConcreteElement classes is hard
 * Visiting across class hierarchies
 * Accumulating state
 * Breaking encapsulation

##### Related Patterns

Composite (163): Visitors can be used to apply an operation over an object structure defined by the Composite pattern. Interpreter (243): Visitor may be applied to do the interpretation.
