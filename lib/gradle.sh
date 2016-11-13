#!/bin/bash

print_h2 "Gradle"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get https://gradle.org/gradle-download/ | grep 'bin.zip' | egrep -o '[0-9]+\.[0-9]+(\.[0-9]+)?' | sortvr | head -n 1)
    file_download \
        --url "https://services.gradle.org/distributions/gradle-$ver-bin.zip" \
        --file "gradle-$ver-bin.zip"
    unzip gradle-$ver-bin.zip > /dev/null
    rm -rf $DIR/usr/applications/gradle
    mv gradle-$ver $DIR/usr/applications/gradle
    rm gradle-$ver-bin.zip
fi
