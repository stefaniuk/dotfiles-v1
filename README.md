dotfiles
========

The aim of the `dotfiles` project is to configure shell and provide a better experience while using command-line.

Installation
------------

All files will be installed in the user directory.

    HOST_NAME="home"
    USER_NAME="Daniel Stefaniuk"
    USER_EMAIL="daniel.stefaniuk@gmail.com"
    curl -L https://raw.githubusercontent.com/stefaniuk/dotfiles/master/setup.sh -o - | /bin/bash -s -- \
        --prepare --update --install --config \
        --minimal --sudo

TODO List
---------

 * Configure tmux on Mac OSX
 * Configure vim on Mac OSX
 * Check thoughtbot's [dotfiles](https://github.com/thoughtbot/dotfiles)
 * Check Justin Force's [dotfiles](https://github.com/justinforce/dotfiles)
 * Check Gediminas Morkevicius' [dotfiles](https://github.com/l3pp4rd/dotfiles)
 * Check Keith Smiley's [dotfiles](https://github.com/keith/dotfiles)
 * Explore [bash-it](https://github.com/revans/bash-it)
 * Explore [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
 * Explore [Prezto](https://github.com/sorin-ionescu/prezto)

See
---

 * [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
 * [Nicolas Gallagher](https://github.com/necolas/dotfiles)
