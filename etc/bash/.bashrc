#!/bin/sh

# must be interactive shell
[[ "$-" != *i* ]] && return

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#### dependencies ##############################################################

source ~/.shell-commons/shell-commons.sh 2> /dev/null
[ $? != 0 ] && source /usr/local/shell-commons/shell-commons.sh 2> /dev/null
source ~/.shell-utils/shell-utils.sh 2> /dev/null
[ $? != 0 ] && source /usr/local/shell-utils/shell-utils.sh 2> /dev/null
source ~/.shell-packages/shell-packages.sh 2> /dev/null
[ $? != 0 ] && source /usr/local/shell-packages/shell-packages.sh 2> /dev/null

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

# configure gradle
if [ -d $SHELL_PACKAGES_HOME_DIR/opt/gradle/current ]; then
    export GRADLE_HOME=$SHELL_PACKAGES_HOME_DIR/opt/gradle/current
    export PATH=$GRADLE_HOME/bin:$PATH
fi
# configure java
if [ -d $SHELL_PACKAGES_HOME_DIR/opt/jdk/current ]; then
    export JAVA_HOME=$SHELL_PACKAGES_HOME_DIR/opt/jdk/current
    export PATH=$JAVA_HOME/bin:$PATH
fi
# make sure PATH variable includes `bin` directory
export PATH=~/bin:$PATH
