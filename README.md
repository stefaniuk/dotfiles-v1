dotfiles
========

Installation
------------

There are two ways you can install the `dotfiles`:

    USER_NAME="Your Name"
    USER_EMAIL="your.name@mail.com"
    git clone https://github.com/stefaniuk/dotfiles.git
    ./dotfiles/bin/install.sh \
        --force-mintleaf --force-oh-my-zsh \
        --update-system --update-packages \
        --skip-installed

or

    USER_NAME="Your Name"
    USER_EMAIL="your.name@mail.com"
    wget https://raw.githubusercontent.com/stefaniuk/dotfiles/master/bin/install.sh -O - | /bin/bash -s -- \
        --force-mintleaf --force-oh-my-zsh \
        --update-system --update-packages \
        --skip-installed

Why to install?
---------------

Because this project includes:

 * [MintLeaf](https://github.com/stefaniuk/mintleaf) installation
 * [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) installation
 * useful options, functions and aliases
 * common programs configuration
 * design to be multi-platform

Credits
-------

 * [mathiasbynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
 * [necolas' dotfiles](https://github.com/necolas/dotfiles)

TODO
----

 * install [grc](http://korpus.juls.savba.sk/~garabik/software/grc.html)
 * check [bash-it](https://github.com/revans/bash-it)
 * configure [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
