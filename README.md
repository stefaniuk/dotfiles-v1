Dotfiles
========

The aim of the `dotfiles` project is to configure Bash to provide a better user experience while using the command-line.

Supported operating systems are:

* macOS
* Ubuntu
* Raspbian
* Limited support for other Linux non-Debian based distributions

Most of the scripts should work well with other Linux distributions. If the installation ends with a message _"Operating system not supported"_ see the [`system_detect` function](https://github.com/stefaniuk/dotfiles/blob/master/.bash_system#L3) and examine the following [condition statement](https://github.com/stefaniuk/dotfiles/blob/master/dotfiles#L188-L191).

Installation
------------

Most common installation on a workstation

    export USER_NAME="Daniel Stefaniuk"
    export USER_EMAIL="daniel.stefaniuk@gmail.com"
    curl -L https://raw.githubusercontent.com/stefaniuk/dotfiles/master/dotfiles -o - | /bin/bash -s -- \
        --update-os \
        --install=dependencies-bundle,system-bundle,admin-bundle \
        --config \
        --sudo

Minimal installation

    curl -L https://raw.githubusercontent.com/stefaniuk/dotfiles/master/dotfiles -o - | /bin/bash -s

All files will be installed in the user's home directory.

After reloading Bash `dotfiles` command should be available on the command-line. Below is a screenshot of an installation of an additional software package managed by the `dotfiles`.

![dotfiles](lib/resources/dotfiles/dotfiles.png)

Testing
-------

This project can be tested in a Docker container provided along with the source code. To use this facility, please make sure that VirtualBox and Vagrant are installed and available on the command-line.

    cd ./opt
    vagrant up
    vagrant ssh
    make build create start install bash

Extensions
----------

* [Manuals](https://github.com/stefaniuk/dotfiles-man)

TODO
----

* Fix `dotfiles-man` installation, i.e. `~/dotfiles --extension-man`
* Better name handling for bundles installation and configuration
* SSH key add function
* Provide functionality to toggle Bash completion and alias scripts in `etc/profile.d`
* Refactor `system_info`
* Fix `system_test`
* Tidy up installation process, i.e. `dependencies` and `system` bundles
* Version `dotfiles`
* [Configure `htop`](http://www.thegeekstuff.com/2011/09/linux-htop-examples)
* Remap the Caps Lock

See
---

###### Dotfiles

* [Gediminas Morkevicius](https://github.com/l3pp4rd/dotfiles)
* [Justin Force](https://github.com/justinforce/dotfiles)
* [Keith Smiley](https://github.com/keith/dotfiles)
* [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
* [Nicolas Gallagher](https://github.com/necolas/dotfiles)
* [Paul Irish](https://github.com/paulirish/dotfiles)
* [Thoughtbot](https://github.com/thoughtbot/dotfiles)

###### Projects

* [bash-it](https://github.com/revans/bash-it)
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* [prezto](https://github.com/sorin-ionescu/prezto)
