#### Mediator (273)

Behavioral pattern, object behavioral

Defines an object that encapsulates how a set of objects interact. Mediator promotes loose coupling by keeping objects from referring to each other explicitly, and it lets you vary their interaction independently.

##### Applicability

Use the Mediator pattern when

 * a set of objects communicate in well-defined but complex ways. The resulting interdependencies are unstructured and difficult to understand.
 * reusing an object is difficult because it refers to and communicates with many other objects.
 * a behavior that's distributed between several classes should be customizable without a lot of subclassing.

##### Collaborations

 * Colleagues send and receive requests from a Mediator object. The mediator implements the cooperative behavior by routing requests between the appropriate colleague(s).

##### Consequences

 * It limits subclassing
 * It decouples colleagues
 * It simplifies object protocols
 * It abstracts how objects cooperate
 * It centralizes control

##### Related Patterns

Facade (185) differs from Mediator in that it abstracts a subsystem of objects to provide a more convenient interface. Its protocol is unidirectional; that is, Facade objects make requests of the subsystem classes but not vice versa. In contrast, Mediator enables cooperative behavior that colleague objects don't or can't provide, and the protocol is multidirectional. Colleagues can communicate with the mediator using the Observer (293) pattern.
