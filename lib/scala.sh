#!/bin/bash

print_h2 "Scala"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get http://www.scala-lang.org/download/ | grep '.tgz' | egrep -o '[0-9]+\.[0-9]+(\.[0-9]+)?' | sortvr | head -n 1)
    file_download \
        --url "http://downloads.lightbend.com/scala/$ver/scala-$ver.tgz" \
        --file "scala-$ver.tgz"
    tar -zxf scala-$ver.tgz
    rm -rf $DIR/usr/applications/scala
    mv scala-$ver $DIR/usr/applications/scala
    rm scala-$ver.tgz
fi
