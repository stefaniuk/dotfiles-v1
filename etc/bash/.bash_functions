#!/bin/sh

# start `php` application
# function runphp {

#     local port="${1:-9000}"

#     local dir=
#     if [ -d ./public ] && [ -f ./public/index.php ]; then
#         dir="."
#     elif [ -d ../public ] && [ -f ../public/index.php ]; then
#         dir=".."
#     elif [ -d ../../public ] && [ -f ../../public/index.php ]; then
#         dir="../.."
#     elif [ -d ../../../public ] && [ -f ../../../public/index.php ]; then
#         dir="../../.."
#     fi

#     if [ -n "$dir" ]; then
#         local pid=$(ps aux | grep -v 'grep' | grep 'php -S 0.0.0.0:9000 -t ./public ./public/index.php' | awk '{ print $2 }')
#         [ -n "$pid" ] && kill -s TERM $pid
#         (
#             cd ${dir}
#             nohup php -S 0.0.0.0:${port} -t ./public ./public/index.php > ~/php.log &
#         )
#         tail -f ~/php.log
#     fi
# }

# change github protocol from https to git
function fix_my_github_urls {

    for file in $(find ~/projects -type f -iname config | grep '\.git'); do
        file_replace_str "url = https://github.com/stefaniuk" "url = git@github.com:stefaniuk" $file
    done
}

# execute functions that requite higher privileges
function please {

    local func="$1"

    local params=( "$@" )   # array containing all parameters
    unset params[0]         # remove first element

    local content="#!/bin/bash\n\n"
    content="${content}params=(\n"
    local regex="\s+"
    for param in "${params[@]}"; do
        if [[ "$param" =~ $regex ]]; then
            content="${content}\t\"${param}\"\n"
        else
            content="${content}\t${param}\n"
        fi
    done
    content="$content)\n"

    local file="$HOME/_sudo.$$"
    echo -e "$content" > $file
    echo "#$( type "$func" )" >> $file
    echo -e "\n$func \"\${params[@]}\"\n" >> $file
    sudo bash $file
    rm $file
}
