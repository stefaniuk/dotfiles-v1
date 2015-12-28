## Coding Standards

#### 1. Introduction

Coding standards are important in any development project, but they are particularly important when many developers are working on the same project. Coding standards help ensure that the code is high quality, has fewer bugs, and can be easily maintained and read by others.

In addition to that the aim of coding standards is to help to write self-documenting code. Please, note that self-documented code does not mean that there should be no documentation or no comments at all, but only that there should be no unnecessary comments. In good, self-documented code, you don't have to explain every single line because every identifier (variable, method, class) has a clear semantic name. Having more comments than necessary actually makes it harder to read the code.

Here are the rules that can help to achieve that. All the rules should not to be blindly followed. Strive to understand them first and ask when in doubt.

#### 2. Rules

##### General

 * Make sure your IDE uses same configuration as other developers.
 * Make sure your IDE has all the relevant plug-ins installed.
 * Always format code for readability, use CTRL + ALT + L.
 * Annotate code with [`@formatter:off`] for custom formatting.
 * Surround code with [`#region ... #endregion`] for folding custom regions. (controversial)
 * Have a clear intent.
 * Keep it simple.
 * Write a test first.
 * Favour code over comments.
 * Refactor to abstraction and design patterns.
 * Always run static analysis before pushing your changes.
 * Learn [keyboard shourcuts] for better performance.

[`#region ... #endregion`]: https://www.jetbrains.com/idea/help/folding-custom-regions-with-line-comments.html
[`@formatter:off`]: https://www.jetbrains.com/phpstorm/help/reformatting-source-code.html
[keyboard shourcuts]: https://www.jetbrains.com/phpstorm/documentation/PhpStorm_ReferenceCard.pdf

##### Object-Oriented

 * Avoid global variables.
 * Avoid long parameter lists.
 * Limit collaborators of an object (entities an object depends on).
 * Limit dependencies of an object (entities that depend on an object).
 * Prefer composition over inheritance.
 * Prefer small classes and methods with a single, well-defined responsibility.

##### PHP

 * [PSR-1]/[PSR-2] coding standards.
 * [Zend Framework Coding Standard] coding standards.
 * If there is a conflict between PSR-1/PSR-2 and Zend Framework coding standards the later one could take the precedence.
 * With time we may decide to tweak the above rules if we feel that there are areas where they are to restrictive or relaxed.

[PSR-1]: https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-1-basic-coding-standard.md
[PSR-2]: https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-2-coding-style-guide.md
[Zend Framework Coding Standard]: http://framework.zend.com/manual/current/en/ref/coding.standard.html

##### PostgreSQL

 * Table name - PascalCase, plural.
 * Column name - camelCase, singular.
 * Avoid multicolumn indexes. Optimize later with a [compound index] if needed.
 * Consider a [partial index] for queries on booleans.
 * Constrain columns as [`NOT NULL`].
 * Index foreign keys.
 * Don't use unnecessary prefixes or suffixes for object names.
 * Create primary key `id` for every table.
 * Fields representing the same kind of data on different tables should be named the same.
 * Foreign keys must be named consistently in different tables, e.g. `Services.id` -> `OtherTable.serviceId`
 * The naming convention syntax for constraints should look like this: `{constraint_type}_{table name}_{field name}`. A two letter prefix could be applied to the constraint name depending on the type: `pk`, `fk`, `ck` or `un`.
 * Use underscores consistently and for a particular purpose. Just general table names should be clear enough with PascalCasing; you don't need underscores to separate words. Save underscores to indicate an associative table.
 * Don't artificially shorten or abbreviate words. It is better for a name to be long and clear than short and confusing.
 * Never make a change to the schema directly.
 * Provide authentication for database access. Don't give the `admin` role to each user.
 * Keep the design in third normal form (3NF) as a minimum.

[compound index]: http://www.postgresql.org/docs/9.4/static/indexes-bitmap-scans.html
[partial index]: http://www.postgresql.org/docs/9.4/static/indexes-partial.html
[`NOT NULL`]: http://www.postgresql.org/docs/9.4/static/ddl-constraints.html

##### Git

 * Create a new branch for each change.
 * Commit and push code at least once a day.
 * Squash multiple trivial commits (non-canonical branches) into a single commit.
 * Write a [good commit message].

[good commit message]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

##### Shell

 * Don't parse the output of `ls`. See [here][parsingls] for details and alternatives
 * Don't use `cat` to provide a file on `stdin` to a process that accepts file arguments itself
 * Don't use `echo` with options, escapes, or variables (use `printf` for those cases)
 * Don't use a `/bin/sh` [shebang] unless you plan to test and run your script on at least: Actual Sh, Dash in POSIX-compatible mode (as it will be run on Debian), and Bash in POSIX-compatible mode (as it will be run on OSX)
 * Don't use any non-POSIX [features][bashisms] when using a `/bin/sh` [shebang]
 * If calling `cd`, have code to handle a failure to change directories
 * If calling `rm` with a variable, ensure the variable is not empty
 * Prefer "$@" over "$\*" unless you know exactly what you're doing
 * Prefer `awk '/re/ { ... }'` to `grep re | awk '{ ... }'`
 * Prefer `find -exec {} +` to `find -print0 | xargs -0`
 * Prefer `for` loops over `while read` loops
 * Prefer `grep -c` to `grep | wc -l`
 * Prefer `mktemp` over using `$$` to "uniquely" name a temporary file
 * Prefer `sed '/re/!d; s//.../'` to `grep re | sed 's/re/.../'`
 * Prefer `sed 'cmd; cmd'` to `sed -e 'cmd' -e 'cmd'`
 * Prefer checking exit statuses over output in `if` statements (`if grep -q ...; `, not `if [ -n "$(grep ...)" ];`)
 * Prefer reading environment variables over process output (`$TTY` not `$(tty)`, `$PWD` not `$(pwd)`, etc)
 * Use `$( ... )`, not backticks for capturing command output
 * Use `$(( ... ))`, not `expr` for executing arithmetic expressions
 * Use `1` and `0`, not `true` and `false` to represent boolean variables
 * Use `find -print0 | xargs -0`, not `find | xargs`
 * Use quotes around every `"$variable"` and `"$( ... )"` expression unless you want them to be word-split and/or interpreted as globs
 * Use the `local` keyword with function-scoped variables
 * Identify common problems with [shellcheck]
 * Break long lines on `|`, `&&`, or `||` and indent the continuations
 * Don't add an extension to executable shell scripts
 * Don't put a line break before `then` or `do`, use `if ...; then` and `while
   ...; do`
 * Use `for x; do`, not `for x in "$@"; do`
 * Use `snake_case` for variable names and `ALLCAPS` for environment variables
 * Use single quotes for strings that don't contain escapes or variables
 * Use two-space indentation

[shebang]: http://en.wikipedia.org/wiki/Shebang_(Unix)
[parsingls]: http://mywiki.wooledge.org/ParsingLs
[bashisms]: http://mywiki.wooledge.org/Bashism
[shellcheck]: http://www.shellcheck.net

##### Bash

In addition to Shell best practices

 * Prefer `${var,,}` and `${var^^}` over `tr` for changing case
 * Prefer `${var//from/to}` over `sed` for simple string replacements
 * Prefer `[[` over `test` or `[`
 * Prefer process substitution over a pipe in `while read` loops
 * Use `((` or `let`, not `$((` when you don't need the result

___

###### References

 1. [DevIQ - Take pride in your code](http://deviq.com/)
 2. [20 Database Design Best Practices](https://dzone.com/articles/20-database-design-best)
 3. [Evolutionary/Agile Database Best Practices](http://agiledata.org/essays/bestPractices.html)
