#!/bin/sh

# must be interactive shell
[[ "$-" != *i* ]] && return

# detect type of terminal session
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || ps -o comm= -p $PPID 2> /dev/null | grep sshd > /dev/null; then
    export SESSION_TYPE="remote"
else
    export SESSION_TYPE="local"
fi

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#### configuration #############################################################

shopt -s nocaseglob # case-insensitive globbing
shopt -s cdspell    # auto-correct typos in path names when using `cd`
shopt -s autocd     # allows `cd **/qux` to enter `./foo/bar/baz/qux`
shopt -s globstar   # pattern `**` used in a file name expansion context will match all files and zero or more directories and subdirectories

# bash completion
[ -f /etc/bash_completion ] && bcpath=/etc || bcpath=/usr/local/etc
if [ -r $bcpath/bash_completion ]; then
    source $bcpath/bash_completion
fi
unset bcpath

#### resources #################################################################

# load dotfiles
for file in ~/.{path,bashrc.*,bash_prompt,bash_exports*,bash_functions*,bash_aliases*,bash_completion*,bash_extra,bash_custom}; do
    [ -r $file ] && source $file
done
unset file

#### path ######################################################################

# make sure PATH variable includes `~/bin` and `~/usr/bin` directories
export PATH=$PATH:~/bin:~/usr/bin
