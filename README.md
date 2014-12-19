dotfiles
========

Installation
------------

There are two ways you can install the `dotfiles`:

    USER_NAME="Your Name"
    USER_EMAIL="your.name@mail.com"
    git clone https://github.com/stefaniuk/dotfiles.git
    sudo ./dotfiles/bin/install.sh \
        --force-mintleaf --force-oh-my-zsh \
        --update-system --update-packages

or

    USER_NAME="Your Name"
    USER_EMAIL="your.name@mail.com"
    wget https://raw.githubusercontent.com/stefaniuk/dotfiles/master/bin/install.sh -O - | sudo bash -s -- \
        --force-mintleaf --force-oh-my-zsh \
        --update-system --update-packages

Available flags:

 - `--common-only`
 - `--force-mintleaf`
 - `--force-oh-my-zsh`
 - flags defined by the [MintLeaf](https://github.com/stefaniuk/mintleaf) project

Why to install?
---------------

Because this project includes:

 * [MintLeaf](https://github.com/stefaniuk/mintleaf) installation
 * [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) installation
 * useful options, functions and aliases
 * common programs configuration
 * design to be multi-platform

Useful information
------------------

 * Bash configuration is splint into the following files that are sourced in such order:
     - `.bashrc`
     - `.bash_prompt`
     - `.bash_exports`
     - `.bash_functions`
     - `.bash_aliases`
     - `.bash_completion`
 * Git configuration and aliases can be found in `.gitconfig` file

Credits
-------

 * [mathiasbynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
 * [necolas' dotfiles](https://github.com/necolas/dotfiles)

TODO
----

 * set terminal emulator's colour scheme to the [Solarized](http://ethanschoonover.com/solarized) palette
 * install [grc](http://korpus.juls.savba.sk/~garabik/software/grc.html)
 * check [bash-it](https://github.com/revans/bash-it)
 * configure [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
