dotfiles
========

The aim of my `dotfiles` project is to configure terminal to provide a better user experience while using the command-line.

Installation
------------

    USER_NAME="Daniel Stefaniuk"
    USER_EMAIL="daniel.stefaniuk@gmail.com"
    curl -L https://raw.githubusercontent.com/stefaniuk/dotfiles/master/setup.sh -o - | /bin/bash -s -- \
        --update \
        --prepare \
        --install \
        --config \
        --sudo

All files will be installed in the user directory.

Testing
-------

This project can be tested in a Docker containers defined in the `test` directory. VirtualBox and Vagrant have to be installed first.

    vagrant up
    vagrant ssh
    make build create start install test

TODO
----

 * Install Node.js on Mac OS X and possibly others
 * Remap the Caps Lock key in Ubuntu
 * Configure `vim`
 * Check Paul Irish's [dotfiles](https://github.com/paulirish/dotfiles)
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
