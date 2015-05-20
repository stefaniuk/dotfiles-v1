#!/bin/sh

# change github protocol from https to git
function fix_github_urls {

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

# convert bytes to human readable text
function byteme {

    local list="bytes,KB,MB,GB,TB,PB,EB,ZB,YB"

    local p=1
    local data=$(cat)
    local v=$(echo "scale=2; $data / 1" | bc)
    local i=$(echo $v / 1024 | bc)
    while [ ! $i = "0" ]; do
        let p=p+1
        v=$(echo "scale=2; $v / 1024" | bc)
        i=$(echo $v / 1024 | bc)
    done
    echo $v$(echo $list | cut -f$p -d,)
}
