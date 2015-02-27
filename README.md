dotfiles
========

The aim of the `dotfiles` project is to configure shell and provide a better experience while using command-line.

Installation
------------

All files will be installed in the user directory

    USER_NAME="Daniel Stefaniuk"
    USER_EMAIL="daniel.stefaniuk@gmail.com"
    wget https://raw.githubusercontent.com/stefaniuk/dotfiles/master/setup.sh -O - | /bin/bash -s -- \
        --update-system \
        --update-packages \
        --install-build-dependencies

TODO list
---------

 * Install display in-line image feature for iTerm (nightly), http://iterm2.com/images.html#/section/home
 * Update shortcuts for Vim
 * Support for man functionality that is based on images, i.e. UML diagrams
 * Provide custom dictionary for Sublime Text and test 'add to dict' function
 * Update functionality
 * Make sure [grc](http://korpus.juls.savba.sk/~garabik/software/grc.html) works correctly
 * Check Gediminas Morkevicius' [dotfiles](https://github.com/l3pp4rd/dotfiles) for anything useful
 * Use [Solarized](http://ethanschoonover.com/solarized) colour palette in terminal
 * Explore [bash-it](https://github.com/revans/bash-it)
 * Explore [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
 * Explore [Prezto](https://github.com/sorin-ionescu/prezto)

See
---

 * [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
 * [Nicolas Gallagher](https://github.com/necolas/dotfiles)
