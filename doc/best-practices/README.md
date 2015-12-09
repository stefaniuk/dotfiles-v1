#### Best Practices

A guide for programming well.

##### General

 * These are not to be blindly followed; strive to understand these and ask when in doubt
 * Don't duplicate the functionality of a built-in library
 * Don't swallow exceptions or "fail silently"
 * Don't write code that guesses at future functionality
 * Exceptions should be exceptional
 * [Keep the code simple]

[Keep the code simple]: http://www.readability.com/~/ko2aqda2

##### Object-Oriented Design

 * Avoid global variables
 * Avoid long parameter lists
 * Limit collaborators of an object (entities an object depends on)
 * Limit an object's dependencies (entities that depend on an object)
 * Prefer composition over inheritance
 * Prefer small methods. Between one and five lines is best
 * Prefer small classes with a single, well-defined responsibility. When a class exceeds 100 lines, it may be doing too many things
 * [Tell, don't ask]

[Tell, don't ask]: http://robots.thoughtbot.com/post/27572137956/tell-dont-ask

##### Postgres

 * Avoid multicolumn indexes in Postgres. It [combines multiple indexes] efficiently. Optimize later with a [compound index] if needed
 * Consider a [partial index] for queries on booleans
 * Constrain most columns as [`NOT NULL`]
 * Index foreign keys

[`NOT NULL`]: http://www.postgresql.org/docs/9.1/static/ddl-constraints.html#AEN2444
[combines multiple indexes]: http://www.postgresql.org/docs/9.1/static/indexes-bitmap-scans.html
[compound index]: http://www.postgresql.org/docs/9.2/static/indexes-bitmap-scans.html
[partial index]: http://www.postgresql.org/docs/9.1/static/indexes-partial.html
[Index foreign keys]: https://tomafro.net/2009/08/using-indexes-in-rails-index-your-associations

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
[shellcheck]: http://www.shellcheck.net/

##### Bash

In addition to Shell best practices

 * Prefer `${var,,}` and `${var^^}` over `tr` for changing case
 * Prefer `${var//from/to}` over `sed` for simple string replacements
 * Prefer `[[` over `test` or `[`
 * Prefer process substitution over a pipe in `while read` loops
 * Use `((` or `let`, not `$((` when you don't need the result

##### Git

 * Avoid merge commits by using a [rebase workflow]
 * Squash multiple trivial commits into a single commit
 * Write a [good commit message]

[rebase workflow]: /protocol/git#merge
[good commit message]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
