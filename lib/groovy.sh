#!/bin/bash

print_h2 "Groovy"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get http://groovy-lang.org/download.html | grep 'apache-groovy-binary-' | egrep -o '[0-9]+\.[0-9]+(\.[0-9]+)?' | sortvr | head -n 1)
    file_download \
        --url "https://dl.bintray.com/groovy/maven/apache-groovy-binary-$ver.zip" \
        --file "apache-groovy-binary-$ver.zip"
    unzip apache-groovy-binary-$ver.zip > /dev/null
    rm -rf $DIR/usr/applications/groovy
    mv groovy-$ver $DIR/usr/applications/groovy
    rm apache-groovy-binary-$ver.zip
fi
