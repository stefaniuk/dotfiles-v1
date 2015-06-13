#### Builder

Creational pattern, object creational

Separates the construction of a complex object from its representation so that the same construction process can create different representations.

##### Applicability

Use the Builder pattern when

 * the algorithm for creating a complex object should be independent of the parts that make up the object and how they're assembled.
 * the construction process must allow different representations for the object that's constructed.

##### Collaborations

 * The client creates the Director object and configures it with the desired Builder object.
 * Director notifies the builder whenever a part of the product should be built.
 * Builder handles requests from the director and adds parts to the product.
 * The client retrieves the product from the builder.

##### Consequences

 * Lets you vary a product's internal representation
 * Isolates code for construction and representation
 * Gives you finer control over the construction process
