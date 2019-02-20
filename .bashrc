#!/bin/sh

# clear prompt command
unset PROMPT_COMMAND
# load default variables
[ -f ~/etc/profile.d/dotfiles-config ] && source ~/etc/profile.d/dotfiles-config
# set alias to allow to reload Bash
alias reload="exec $SHELL -l"

if [[ ! "$BASH_LOAD_DOTFILES" =~ ^(true|yes|y|on|1|TRUE|YES|Y|ON)$ ]]; then
    return
fi

#### functions #################################################################

# Used to mesure command execution time in seconds
function __measure_exec_time {
    if [[ "$BASH_MEASURE_EXEC_TIME" =~ ^(true|yes|y|on|1|TRUE|YES|Y|ON)$ ]]; then
        t1=$(gdate +%s.%N || date +%s.%N)
    fi
    $*
    if [[ "$BASH_MEASURE_EXEC_TIME" =~ ^(true|yes|y|on|1|TRUE|YES|Y|ON)$ ]]; then
        t2=$(gdate +%s.%N || date +%s.%N)
        runtime=$(printf "%05.2f" $(echo "$t2 - $t1" | bc -l))
        echo "${runtime}s : $*"
    fi
}

#### initialisation ############################################################

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

shopt -s autocd     # allows `cd **/qux` to enter `./foo/bar/baz/qux`
shopt -s cdspell    # auto-correct typos in path names when using `cd`
shopt -s dotglob    # include filenames beginning with a `.` in the results of filename expansion
shopt -s globstar   # pattern `**` used in a file name expansion context will match all files and zero or more directories and subdirectories
shopt -s nocaseglob # case-insensitive globbing

# bash completion
[ -f /etc/bash_completion ] && bcpath=/etc || bcpath=/usr/local/etc
if [ -f $bcpath/bash_completion ]; then
    __measure_exec_time source $bcpath/bash_completion
fi
unset bcpath

#### resources #################################################################

# load Bash configuration files
for file in ~/.{path,bashrc.,bash_system,bash_prompt,bash_exports,bash_functions,bash_asserts,bash_aliases,bash_completion,bash_extra,bash_custom}*; do
    [ -f $file ] && __measure_exec_time source $file
done
# load Profile configuration files
for file in ~/etc/profile.d/*; do
    [ -f $file ] && __measure_exec_time source $file
done
unset file

#### path ######################################################################

# make sure PATH variable includes `~/bin` and `~/usr/bin` directories
export PATH=$PATH:~/bin:~/usr/bin
