dotfiles
========

The aim of the `dotfiles` project is to configure shell and provide a better experience while using command-line.

Installation
------------

All files will be installed in the user directory

    USER_NAME="Your Name"
    USER_EMAIL="your.name@mail.com"
    wget https://raw.githubusercontent.com/stefaniuk/dotfiles/master/installer.sh -O - | /bin/bash -s -- \
        --update-system \
        --update-packages

TODO list
---------

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
