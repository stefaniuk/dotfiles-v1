dotfiles
========

The aim of my `dotfiles` project is to configure Bash and Zsh to provide a better experience while using command-line.

Installation
------------

All files will be installed in the user directory.

    USER_NAME="Daniel Stefaniuk"
    USER_EMAIL="daniel.stefaniuk@gmail.com"
    curl -L https://raw.githubusercontent.com/stefaniuk/dotfiles/master/setup.sh -o - | /bin/bash -s -- \
        --update \
        --prepare \
        --install=system,common,server,workstation \
        --config \
        --sudo

Testing
-------

This project can be tested in the Docker containers defined in the `test` directory. VirtualBox and Vagrant have to be installed first.

```bash
vagrant up
vagrant ssh
make build create start install test stop OS=debian
```

TODO
----

 * Install and configure `jekyll`
 * Install and configure `packer`
 * Install and configure `gpg2`
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
