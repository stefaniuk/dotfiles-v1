## Code Review

#### 1. Everyone

 * Accept that many programming decisions are opinions. Discuss trade-offs, which you prefer, and reach a resolution quickly.
 * Ask questions; don't make demands.
 * Ask for clarification.
 * Avoid selective ownership of code. ("mine", "not mine", "yours")
 * Avoid using terms that could be seen as referring to personal traits.
 * Be explicit. Remember people don't always understand your intentions.
 * Be humble.
 * Don't use sarcasm.
 * Talk in person if there are too many "I didn't understand" or "Alternative solution:" comments. Post a follow-up comment summarising off-line discussion.

#### 2. Having Your Code Reviewed

 * Be grateful for the reviewer's suggestions.
 * Don't take it personally. The review is of the code, not you.
 * Explain why the code exists. ("It's like that because of these reasons. Would it be more clear if I rename this class/file/method/variable?")
 * Extract some changes and refactorings into future tickets/stories.
 * Push commits based on earlier rounds of feedback as isolated commits to the branch. Do not squash until the branch is ready to merge. Reviewers should be able to read individual updates based on their earlier feedback.
 * Seek to understand the reviewer's perspective.
 * Try to respond to every comment.
 * Keep the code short. Beyond 200 lines the effectiveness of a review drops significantly.
 * Provide context. Link to any related tickets, or the specification. Provide short, but useful commit messages.

#### 3. Reviewing Code

Understand why the code is necessary (bug, refactoring, user experience). Then:

 * Communicate which ideas you feel strongly about and those you don't.
 * Identify ways to simplify the code while still solving the problem.
 * If discussions turn too philosophical or academic, move the discussion off-line to a regular Friday afternoon technique discussion. In the meantime, let the author make the final decision on alternative implementations.
 * Offer alternative implementations, but assume the author already considered
  them. ("What do you think about using a custom validator here?")
 * Seek to understand the author's perspective.
 * Sign off on the merge request with a :thumbsup: or "Ready to merge" comment.
 * Code review often and for short sessions.
 * It's OK to say "It's all good".

#### 4. Checklist

##### General

 * Does the code work?
 * Does the code make sense and read well?
 * Is it as modular as possible?
 * Is it on the appropriate level of abstraction?
 * Does it make use of the design patterns?
 * Does it conform to the agreed coding conventions?
 * Can any of the code be replaced with library functions?

##### Security

 * Is input checked and decoded when appropriate?
 * Is output checked and encoded when appropriate?
 * Are invalid parameters handled?
 * Are exceptions coming from the lower layers of the application being caught?
 * Are log entries produced for the auditing and debugging purpose?

##### Testing

 * Do unit and integration tests exist and are they comprehensive?
 * Is the all code testable?

##### Documentation

 * Are all classes and methods commented?
 * Is any unusual behaviour or edge-case handling described?
 * Is there any incomplete code? If so,
    - it should be removed or
    - flagged with a suitable marker like `TODO:` or `FIXME:`
 * Are self-explanatory design patterns used over extensive documentation?
 * Are tests written in such a way that can serve as documentation?

**Use "*Coding Best Practices*" list as a reference to support your review.**

___

###### References

 1. [Best Practices For Peer Code Review](http://smartbear.com/all-resources/articles/best-practices-for-peer-code-review/)
 2. [Code Review Best Practices](http://kevinlondon.com/2015/05/05/code-review-best-practices.html)
