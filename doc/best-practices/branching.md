## Branching

#### 1. Branch Types

There are four types of branches:

 * Master
 * Release
 * Feature
 * Support

Additional branches:

 * Maintenance - used only to organise physical structure of a project

##### 1.1 Master

The master branch should at all times reflect what is in live. When a phase of development is to be released to live the release branch is merged into the master. This branch MUST be releasable at all times.

##### 1.2 Release

All development for project sprint [x] happens in a branch named `release/sprint-[x]` where [x] starts at 1 and increments with each new project cycle. For example, phase one of development happens on the `release/sprint-1` branch.

There might be an occasion that some of the development activities need to be done outside of the sprint lifecycle. Then a branch name format could be as follows `release/release-[name]`.

A release branch must be created from master and be merged back to master using the `--no-ff` flag.

##### 1.3 Feature

Release branches and master are only touched by the team lead. Developers will create a feature or support branches as needed. These are merged by the lead when finished.

Development for pre-launch features are branched from `release/sprint-[x]`.
The naming convention is:

 - `feature/sprint-[x]/pd-[number]` if the change corresponds to a ticket or alternatively
 - `feature/sprint-[x]/[name]` with short and descriptive name where for example `name` can read `fix-postcode-issue`
 - `feature/pd-[number]` when development is done outside of any sprint
 - in a case when no release branch is present `feature/[name]` can be created directly from `master`

When ready, it gets merged back into `release/sprint-[x]` using the `--no-ff` flag and then deleted.

Smaller commits within the feature branch can be combined into larger ones, which could be useful if we want to wrap up the day's work or if we would like to package our changes differently. However, only do this on commits that have not been pushed to an external repository. If others have based work off of the commits that are just about to be deleted, plenty of conflicts can occur - do not rewrite your history if it has been shared with others.

To squash [n] last commits you can use `git rebase -i HEAD~[n]` command.

##### 1.4 Support

Development for post-launch support calls are branched from master. Branch names should consist of a ticket number and a short description. Development for support call #1357: *"Form is full of worms"* would be done on a branch named `support/1357-form-worms`.

#### 2. Commits

Here is a model Git commit message:

    Capitalised, short (50 chars or less) summary

    More detailed explanatory text, if necessary.  Wrap it to about 72
    characters or so.  In some contexts (e.g. automated email), the first
    line is treated as the subject and the rest of the text as the body. The
    blank line separating the summary from the body is critical (unless you
    omit the body entirely).

    Write your commit message in the imperative: "Fix bug" and not "Fixed bug"
    or "Fixes bug". This convention matches up with commit messages generated
    by commands like git merge and git revert.

    Further paragraphs come after blank lines.

    + Bullet points are okay, too

    + Typically a hyphen or asterisk is used for the bullet, followed by a
      single space, with blank lines in between, but conventions vary here

    + Use a hanging indent

___

###### References

 1. [Git: Basics and Best Practices](https://www.palantir.net/sites/default/files/Git_merge_deck.pdf)
 2. [Zend Framework Maintainers Guide](https://github.com/zendframework/maintainers/blob/master/MAINTAINERS.md)
 3. [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)
 4. [Git-flow Cheatsheet](http://danielkummer.github.io/git-flow-cheatsheet/)
