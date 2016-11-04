#### Iterator (257)

Behavioral pattern, object behavioral

Provides a way to access the elements of an aggregate object sequentially without exposing its underlying representation.

##### Applicability

Use the Iterator pattern

 * to access an aggregate object's contents without exposing its internal representation.
 * to support multiple traversals of aggregate objects.
 * to provide a uniform interface for traversing different aggregate structures (that is, to support polymorphic iteration).

##### Collaborations

 * A ConcreteIterator keeps track of the current object in the aggregate and can compute the succeeding object in the traversal.

##### Consequences

 * It supports variations in the traversal of an aggregate
 * Iterators simplify the Aggregate interface
 * More than one traversal can be pending on an aggregate

##### Related Patterns

Composite (163): Iterators are often applied to recursive structures such as Composites. Factory Method (107): Polymorphic iterators rely on factory methods to instantiate the appropriate Iterator subclass. Memento (283) is often used in conjunction with the Iterator pattern. An iterator can use a memento to capture the state of an iteration. The iterator stores the memento internally.
