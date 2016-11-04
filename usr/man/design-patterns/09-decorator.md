#### Decorator (175)

Structural pattern, object structural

Attaches additional responsibilities to an object dynamically. Decorators provide a flexible alternative to subclassing for extending functionality.

##### Applicability

Use Decorator

 * to add responsibilities to individual objects dynamically and transparently, that is, without affecting other objects.
 * for responsibilities that can be withdrawn.
 * when extension by subclassing is impractical. Sometimes a large number of independent extensions are possible and would produce an explosion of subclasses to support every combination. Or a class definition may be hidden or otherwise unavailable for subclassing.

##### Collaborations

 * Decorator forwards requests to its Component object. It may optionally perform additional operations before and after forwarding the request.

##### Consequences

 * More flexibility than static inheritance
 * Avoids feature-laden classes high up in the hierarchy
 * A decorator and its component aren't identical
 * Lots of little objects

##### Related Patterns

Adapter (139): A decorator is different from an adapter in that a decorator only changes an object's responsibilities, not its interface; an adapter will give an object a completely new interface. Composite (163): A decorator can be viewed as a degenerate composite with only one component. However, a decorator adds additional responsibilities—it isnt intended for object aggregation. Strategy (315): A decorator lets you change the skin of an object; a strategy lets you change the guts. These are two alternative ways of changing an object.
