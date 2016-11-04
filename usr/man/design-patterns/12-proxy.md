#### Proxy (207)

Structural pattern, object structural

Provides a surrogate or placeholder for another object to control access to it.

##### Applicability

Proxy is applicable whenever there is a need for a more versatile or sophisticated reference to an object than a simple pointer. Here are several common situations in
which the Proxy pattern is applicable:

 1. A remote proxy provides a local representative for an object in a different address space.
 2. A virtual proxy creates expensive objects on demand. The ImageProxy described in the Motivation is an example of such a proxy.
 3. A protection proxy controls access to the original object. Protection proxies are useful when objects should have different access rights.
 4. A smart reference is a replacement for a bare pointer that performs additional actions when an object is accessed. Typical uses include
    - counting the number of references to the real object so that it can be freed automatically when there are no more references (also called smart pointers).
    - loading a persistent object into memory when it's first referenced.
    - checking that the real object is locked before it's accessed to ensure that no other object can change it.

##### Collaborations

 * Proxy forwards requests to RealSubject when appropriate, depending on the kind of proxy.

##### Consequences

The Proxy pattern introduces a level of indirection when accessing an object. The additional indirection has many uses, depending on the kind of proxy:

 1. A remote proxy can hide the fact that an object resides in a different address space.
 2. A virtual proxy can perform optimizations such as creating an object on demand.
 3. Both protection proxies and smart references allow additional housekeeping tasks when an object is accessed.

##### Related Patterns

Adapter (139): An adapter provides a different interface to the object it adapts. In contrast, a proxy provides the same interface as its subject. However, a proxy used for access protection might refuse to perform an operation that the subject will perform, so its interface may be effectively a subset of the subject's. Decorator (175): Although decorators can have similar implementations as proxies, decorators have a different purpose. A decorator adds one or more responsibilities to an object, whereas a proxy controls access to an object. Proxies vary in the degree to which they are implemented like a decorator. A protection proxy might be implemented exactly like a decorator. On the other hand, a remote proxy will not contain a direct reference to its real subject but only an indirect reference, such as "host ID and local address on host." A virtual proxy will start off with an indirect reference such as a file name but will eventually obtain and use a direct reference.
