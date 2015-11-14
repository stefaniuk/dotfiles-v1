#!/bin/bash

function assert_eq {

    local arg1=$(echo "$1" | sed "s/^[ ]*//g")
    local arg2=$(echo "$2" | sed "s/^[ ]*//g")
    local prog="$(basename $0 .test)"

    if [ ! "$arg1" == "$arg2" ]; then
        print_err "test $prog error"
    else
        echo "test $prog ok"
    fi
}

function assert_not_eq {

    local arg1=$(echo "$1" | sed "s/^[ ]*//g")
    local arg2=$(echo "$2" | sed "s/^[ ]*//g")
    local prog="$(basename $0 .test)"

    if [ "$arg1" == "$arg2" ]; then
        print_err "test $prog error"
    else
        echo "test $prog ok"
    fi
}

function assert_lt {

    local arg1=$1
    local arg2=$2
    local prog="$(basename $0 .test)"

    if [ ! $arg1 -lt $arg2 ]; then
        print_err "test $prog error"
    else
        echo "test $prog ok"
    fi
}

function assert_le {

    local arg1=$1
    local arg2=$2
    local prog="$(basename $0 .test)"

    if [ ! $arg1 -le $arg2 ]; then
        print_err "test $prog error"
    else
        echo "test $prog ok"
    fi
}

function assert_gt {

    local arg1=$1
    local arg2=$2
    local prog="$(basename $0 .test)"

    if [ ! $arg1 -gt $arg2 ]; then
        print_err "test $prog error"
    else
        echo "test $prog ok"
    fi
}

function assert_ge {

    local arg1=$1
    local arg2=$2
    local prog="$(basename $0 .test)"

    if [ ! $arg1 -ge $arg2 ]; then
        print_err "test $prog error"
    else
        echo "test $prog ok"
    fi
}

function assert_between {

    local arg1=$1
    local arg2=$2
    local arg3=$3
    local prog="$(basename $0 .test)"

    if [ $arg1 -lt $arg2 ] || [ $arg1 -gt $arg3 ]; then
        print_err "test $prog error"
    else
        echo "test $prog ok"
    fi
}

function assert_contains {

    local arg1="$1"
    local arg2="$2"
    local prog="$(basename $0 .test)"

    if ! contains "$arg1" "$arg2"; then
        print_err "test $prog error"
    else
        echo "test $prog ok"
    fi
}

function assert_length {

    local arg1=$1
    local arg2=$2
    local prog="$(basename $0 .test)"

    if [ ${#arg1} -ne $arg2 ]; then
        print_err "test $prog error"
    else
        echo "test $prog ok"
    fi
}

function assert_result_pos {

    assert_eq $1 0
}

function assert_result_neg {

    assert_gt $1 0
}

function assert_files_exist {

    local prog="$(basename $0 .test)"

    local result="ok"
    for file in "$@"; do
        if [ ! -s $file ]; then
            result="error"
            break
        fi
    done
    if [ $result != "ok" ]; then
        print_err "test $prog error"
    else
        echo "test $prog ok"
    fi
}

function assert_prog_exists {

    local progs=$*

    for prog in $progs; do
        if [ `which $prog 2> /dev/null | wc -l` -gt 0 ] || [ `alias $prog 2> /dev/null | wc -l` -gt 0  ] || declare -f -F $prog > /dev/null; then
            echo "program ${prog} ok"
        else
            print_err "program ${progs} missing"
        fi
    done
}

function assert_skip_test {

    local arg="$1"
    local prog="$(basename $0 .test)"

    if [ -z "$arg" ]; then
        echo "test $prog skip"
    else
        echo "test $prog skip: \"$arg\""
    fi
}

function assert_skip_slow_test {

    assert_skip_test "too slow"
}
