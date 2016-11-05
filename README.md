dotfiles
========

The aim of the `dotfiles` project is to configure Bash to provide a better user experience while using the command-line.

Installation
------------

Most common installation

    USER_NAME="Daniel Stefaniuk"
    USER_EMAIL="daniel.stefaniuk@gmail.com"
    curl -L https://raw.githubusercontent.com/stefaniuk/dotfiles/master/dotfiles -o - | /bin/bash -s -- \
        --update \
        --install=dependencies,utils-package,tools-package,workstation-package,subl,chrome \
        --config=all \
        --sudo

Minimal installation

    curl -L https://raw.githubusercontent.com/stefaniuk/dotfiles/master/dotfiles -o - | /bin/bash -s -- \
        --config=bash \
        --minimal

All files will be installed in the user's home directory.

Testing
-------

This project can be tested in a Docker container defined in the `./usr/test/etc` directory. To use this facility, please make sure that VirtualBox and Vagrant are installed.

    vagrant up
    vagrant ssh
    make build create start install bash

TODO
----

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
