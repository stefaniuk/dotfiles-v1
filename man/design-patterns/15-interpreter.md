#### Interpreter (243)

Behavioral pattern, object behavioral

Given a language, defines a represention for its grammar along with an interpreter that uses the representation to interpret sentences in the language.

##### Applicability

Use the Interpreter pattern when there is a language to interpret, and you can represent statements in the language as abstract syntax trees. The Interpreter pattern works best when

 * the grammar is simple. For complex grammars, the class hierarchy for the grammar becomes large and unmanageable. Tools such as parser generators are a better alternative in such cases. They can interpret expressions without building abstract syntax trees, which can save space and possibly time.
 * efficiency is not a critical concern. The most efficient interpreters are usually not implemented by interpreting parse trees directly but by first translating them into another form. For example, regular expressions are often transformed into state machines. But even then, the translator can be implemented by the Interpreter pattern, so the pattern is still applicable.

##### Collaborations

 * The client builds (or is given) the sentence as an abstract syntax tree of NonterminalExpression and TerminalExpression instances. Then the client initializes the context and invokes the Interpret operation.
 * Each NonterminalExpression node defines Interpret in terms of Interpret on each subexpression. The Interpret operation of each TerminalExpression defines the base case in the recursion.
 * The Interpret operations at each node use the context to store and access the state of the interpreter.

##### Consequences

 * It's easy to change and extend the grammar
 * Implementing the grammar is easy, too
 * Complex grammars are hard to maintain
 * Adding new ways to interpret expressions

##### Related Patterns

Composite (163): The abstract syntax tree is an instance of the Composite pattern. Flyweight (195) shows how to share terminal symbols within the abstract syntax tree. Iterator (257): The interpreter can use an Iterator to traverse the structure. Visitor (331) can be used to maintain the behavior in each node in the abstract syntax tree in one class.
