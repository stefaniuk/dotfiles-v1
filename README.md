dotfiles
========

The aim of the `dotfiles` project is to configure shell and provide a better experience while using command-line.

Installation
------------

There are two ways the `dotfiles` project can be installed:

    USER_NAME="Your Name"
    USER_EMAIL="your.name@mail.com"
    git clone https://github.com/stefaniuk/dotfiles.git
    sudo ./dotfiles/bin/install.sh --update-system --update-packages

or

    USER_NAME="Your Name"
    USER_EMAIL="your.name@mail.com"
    wget https://raw.githubusercontent.com/stefaniuk/dotfiles/master/bin/install.sh -O - | sudo bash -s -- --update-system --update-packages

Here is the list of other installation flags:

 - `--common-only` to exclude operating system specific configuration
 - `--force-mintleaf`
 - `--force-oh-my-zsh`
 - flags defined by the [MintLeaf](https://github.com/stefaniuk/mintleaf) project

Why to install?
---------------

During development I tried to follow the best practices and coding standards. This project includes the following:

 * [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)
 * Useful shell configuration options
 * Custom functions and aliases
 * Configuration of common programs

TODO list
---------

 * Make sure [grc](http://korpus.juls.savba.sk/~garabik/software/grc.html) works correctly
 * Check Gediminas Morkevicius' [dotfiles](https://github.com/l3pp4rd/dotfiles) for anything useful
 * Use [Solarized](http://ethanschoonover.com/solarized) colour palette in terminal
 * Explore [bash-it](https://github.com/revans/bash-it)
 * Configure [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

Credits
-------

 * [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
 * [Nicolas Gallagher](https://github.com/necolas/dotfiles)
