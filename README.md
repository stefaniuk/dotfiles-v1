dotfiles
========

The aim of the `dotfiles` project is to configure shell and provide a better experience while using command-line.

Installation
------------

All files will be installed in the user directory

    USER_NAME="Daniel Stefaniuk"
    USER_EMAIL="daniel.stefaniuk@gmail.com"
    wget https://raw.githubusercontent.com/stefaniuk/dotfiles/master/setup.sh -O - | /bin/bash -s -- \
        --prepare \
        --update-system --update-packages \
        --install \
        --config \
        --sudo

Additional options that can be used from the command-line during the installation

    --vm
    --install-build-tools
    --install-server-tools
    --install-workstation-tools
    --synchronise-only
    --force-download

TODO List
---------

 * Install `grc` for SL
 * Install VirtualBox, Vagrant, Docker, Packaer and Puppet by default where appropriate
 * Custom file templates and project generators
 * Configure Vim and Atom
 * Update Midnight Commander, Vim and Atom shortcuts
 * Install display in-line image feature for iTerm (nightly), http://iterm2.com/images.html#/section/home
 * Support for man functionality that is based on images, i.e. UML diagrams
 * Provide custom dictionary for Sublime Text and test 'add to dict' function
 * Make sure [grc](http://korpus.juls.savba.sk/~garabik/software/grc.html) works correctly
 * Check Justin Force's [dotfiles](https://github.com/justinforce/dotfiles)
 * Check Gediminas Morkevicius' [dotfiles](https://github.com/l3pp4rd/dotfiles) for anything useful
 * Explore [bash-it](https://github.com/revans/bash-it)
 * Explore [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
 * Explore [Prezto](https://github.com/sorin-ionescu/prezto)

See
---

 * [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
 * [Nicolas Gallagher](https://github.com/necolas/dotfiles)
