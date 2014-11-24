#!/bin/sh

#### dependencies ##############################################################

# load MintLeaf
export MINTLEAF_HOME=/usr/local/mintleaf
source $MINTLEAF_HOME/bin/bootstrap

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

# make sure PATH variable includes `bin` directories in the right order
export PATH=~/bin:/usr/local/bin:$PATH
